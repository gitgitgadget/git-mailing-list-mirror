From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: add support for --bool and --int while setting values
Date: Tue, 26 Jun 2007 19:13:32 -0700
Message-ID: <7vbqf2ta9f.fsf@assigned-by-dhcp.pobox.com>
References: <1182780024442-git-send-email-frank@lichtenheld.de>
	<467FCBEA.906B14@eudaptics.com>
	<20070625161401.GW19725@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Jun 27 04:13:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3N2F-0000qj-NI
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 04:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbXF0CNe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 22:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754353AbXF0CNe
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 22:13:34 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:58396 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbXF0CNd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 22:13:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627021334.UGTG6565.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 22:13:34 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GSDY1X00G1kojtg0000000; Tue, 26 Jun 2007 22:13:33 -0400
In-Reply-To: <20070625161401.GW19725@planck.djpig.de> (Frank Lichtenheld's
	message of "Mon, 25 Jun 2007 18:14:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51007>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> On Mon, Jun 25, 2007 at 04:06:34PM +0200, Johannes Sixt wrote:
>> Frank Lichtenheld wrote:
>> > 
>> > Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
>> 
>> Please excuse if I'm missing the big picture, but why do we need this
>> change?
>
> - Of course the user or script calling git-config can do the
>   normalization and error checking, if they want to. But I would
>   prefer to have it available in git-config.
> - I would prefer that these options wouldn't be silently ignored,
>   because that can be confusing (at least it is documented now, but
>   still). So we should either using them or error out. I prefer the former.
>
> Something that I forgot to mention in the previous mail:
> One real problem with the patch is that it expands the k,m,g suffixes
> for integer values. It probably shouldn't do that.

How about doing something like this, then?

git_config_int() knows that a missing value is a nonsense and
barfs on such an input, so (value ? value : "") is redundant
here.  Besides, you check value == NULL much earlier in this
function.


diff --git a/builtin-config.c b/builtin-config.c
index 9973f94..33b60ec 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -148,10 +148,11 @@ char* normalize_value(const char* key, const char* value)
 	if (type == T_RAW)
 		normalized = xstrdup(value);
 	else {
-		normalized = xmalloc(64);
-		if (type == T_INT)
-			sprintf(normalized, "%d",
-				git_config_int(key, value?value:""));
+		normalized = xmalloc(64 + strlen(value));
+		if (type == T_INT) {
+			int v = git_config_int(key, value);
+			sprintf(normalized, "%d # %s", v, value);
+		}
 		else if (type == T_BOOL)
 			sprintf(normalized, "%s",
 				git_config_bool(key, value) ? "true" : "false");
