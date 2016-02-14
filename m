From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH 1/5] bisect: read bisect paths with strbuf_getline()
Date: Sun, 14 Feb 2016 22:01:51 +0100
Message-ID: <56C0EB3F.90202@moritzneeb.de>
References: <56ACF82B.2030005@moritzneeb.de> <56ACFB03.3020000@moritzneeb.de>
 <xmqqlh74unja.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 22:02:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aV3nq-0005R2-UQ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 22:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbcBNVBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 16:01:54 -0500
Received: from moritzneeb.de ([78.47.1.106]:60735 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbcBNVBx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 16:01:53 -0500
Received: from [192.168.1.3] (x4db453fc.dyn.telefonica.de [77.180.83.252])
	by moritzneeb.de (Postfix) with ESMTPSA id D6A7B1C04F;
	Sun, 14 Feb 2016 22:01:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1455483712;
	bh=6F5scajX2leB2FXyA5XaXkA4bAopgoC3zRYk9+/Mwuo=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
	b=kt86X/6tUdm4K0wa6Evw9AYU/UHxKQTpz1bgWuZSg0c787IeqGS0qDWHMFAFyHVCo
	 peWz1xw9fUVyO4nj7XnSbmpoo5vPVpxwe+txiSbpO+ezQGDbm3JmdQrYDgMKeCy4S6
	 svYIzs7BVKLYlBSuZpcx5vkafNA2Y/M2JH5/VJxk=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqqlh74unja.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286162>

On 02/01/2016 10:30 PM, Junio C Hamano wrote:
> Moritz Neeb <lists@moritzneeb.de> writes:
> 
>>     The lines read from BISECT_NAMES are trimmed with strbuf_trim()
>>     immediately. There is thus no logic expecting CR, so
>>     strbuf_getline_lf() can be replaced by its CRLF counterpart.
> 
> We do not indent the whole log message.

Thanks for spotting, I will change that in the next iteration.
 
> You would also want to think about the necessity of strbuf_trim()
> here.  Now strbuf_getline() would trim the trailing CR, would we
> still need to call strbuf_trim() here?  The code will break if you
> just remove the call, but on the other hand, you will realize that
> the trimming done by calling it is excessive and unnecessary, once
> you inspect the code and learn who writes the file being read here
> and how.

I am not sure what you mean by excessive: How much can I assume that
the input is like expected? The files we are talking about are supposed
to be read and written by git only. But could be modified in theory with
an editor, right? Then things could break, right? This question maybe holds
true for the other patches as well, I still have to look into them.

Assuming that things are just like expected, what has to be done in
read_bisect_paths before dequoting is to remove the leading space,
which is added by 'git rev-parse --sq-quote "$@"' in git-bisect.sh.

I am just not sure, where to remove it:
* in sq_quote_argv? - see some analysis below.
* in read_bisect_paths via strbuf_ltrim instead of strbuf_trim,
  is that what you meant?
* in sq_dequote_argv_array? - see below as well.

I tried to understand, why the space is added by sq_quote_argv() in quotes.c
in the first place. It is there since the beginning in 7cf6720. I have the
feeling that the space is redundant for bisect, because the only other codepath
where BISECT_NAMES is read is in bisect_visualize(), where the necessary space
to separate the arguments is added before '$(...)':

eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")

Other places where sq_quote_argv() and sq_dequote_to_argv_array() are called
as well are builtin/am.c and trace.c.

In builtin/am.c when reading 'apply-opt', the data is trimmed in read_state_file,
so the space in the beginning is superfluous.

Looking at trace.c it gets clear that this code is dependent on this space,
otherwise the trace output will look like "trace: built-in: git'status'"
which is obviously bogus. It would maybe make more sense to add this space
directly there than to trim it in all the other places. I realized that this
code came up in 7cf6720 as well which explains why things are like they are
(and why I'm CC'ing Christian Couder).

Another option, at the moment my favourite because I think it's the least invasive,
would be to "trim" this one space directly in sq_dequote_step(). See the patch below.
This would not affect the tracing functionality, because there is no dequoting used.

-- >8 --
Subject: [PATCH] quote: remove leading space in sq_dequote_step

Because sq_quote_argv adds a leading space (which is expected in trace.c),
sq_dequote_step should remove this space again, such that the operations
of quoting and dequoting are inverse of each other.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
quote.c | 2 ++
1 file changed, 2 insertions(+)

diff --git a/quote.c b/quote.c
index fe884d2..2714f27 100644
--- a/quote.c
+++ b/quote.c
@@ -63,6 +63,8 @@ static char *sq_dequote_step(char *arg, char **next)
char *src = arg;
char c;

+ if (*src == ' ')
+ src++;
if (*src != '\'')
return NULL;
for (;;) {
-- 
2.4.3
