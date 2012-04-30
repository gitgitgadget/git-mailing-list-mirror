From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git log -z still outputting newlines?
Date: Mon, 30 Apr 2012 21:02:51 +0200
Message-ID: <87zk9toxes.fsf@thomas.inf.ethz.ch>
References: <86ty01qez7.fsf@red.stonehenge.com> <m2pqaprrup.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Apr 30 21:03:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOvsB-0008Kz-2Q
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 21:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176Ab2D3TCz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 15:02:55 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:55010 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151Ab2D3TCy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 15:02:54 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Mon, 30 Apr
 2012 21:02:51 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Apr
 2012 21:02:51 +0200
In-Reply-To: <m2pqaprrup.fsf@igel.home> (Andreas Schwab's message of "Mon, 30
	Apr 2012 20:34:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196594>

Andreas Schwab <schwab@linux-m68k.org> writes:

> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>
>> $ git log -z --format=3D'%cE' -5 | od -c
>> 0000000    g   i   t   s   t   e   r   @   p   o   b   o   x   .   c=
   o
>> 0000020    m  \n   g   i   t   s   t   e   r   @   p   o   b   o   x=
   .
>> 0000040    c   o   m  \n   g   i   t   s   t   e   r   @   p   o   b=
   o
>> 0000060    x   .   c   o   m  \n   g   i   t   s   t   e   r   @   p=
   o
>> 0000100    b   o   x   .   c   o   m  \n   g   i   t   s   t   e   r=
   @
>> 0000120    p   o   b   o   x   .   c   o   m  \n                    =
   =20
>> 0000132
>>
>> Why are all those newlines in there?  Bug?  Misfeature?  Feature?  I=
f
>> feature, how do I ensure \0 in my output?  If I add %x00, I get both=
 \0
>> *and* \n in output. :(
>
> --format=3Dformat:%cE respects the -z option.

The underlying problem is apparently that --format=3D%cE triggers the
format-guessing logic, which assumes you meant --pretty=3Dtformat:%cE
instead of --pretty=3Dformat:%cE.

It's probably a bug that --pretty=3Dtformat:%cE does not use \0 here.
After all the manual states

  =C2=B7 tformat:

    The tformat: format works exactly like format:, except that it
    provides "terminator" semantics instead of "separator" semantics.

=46ixing it may be as easy as the patch below, but I haven't spent much
time on it.

diff --git i/log-tree.c w/log-tree.c
index 34c49e7..44f0268 100644
--- i/log-tree.c
+++ w/log-tree.c
@@ -682,7 +682,7 @@ void show_log(struct rev_info *opt)
 	if (opt->use_terminator) {
 		if (!opt->missing_newline)
 			graph_show_padding(opt->graph);
-		putchar('\n');
+		putchar(opt->diffopt.line_termination);
 	}
=20
 	strbuf_release(&msgbuf);

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
