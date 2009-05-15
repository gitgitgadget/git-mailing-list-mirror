From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] builtin-log: Add options to --coverletter
Date: Fri, 15 May 2009 11:11:13 -0700
Message-ID: <7v63g2tewu.fsf@alter.siamese.dyndns.org>
References: <1242349041.646.8.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Fri May 15 20:11:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M51sT-0004L7-6b
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 20:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757410AbZEOSLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2009 14:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756734AbZEOSLP
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 14:11:15 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:41877 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756724AbZEOSLM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 14:11:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090515181113.XRAZ2915.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 15 May 2009 14:11:13 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id ruBD1b0064aMwMQ03uBDnx; Fri, 15 May 2009 14:11:13 -0400
X-Authority-Analysis: v=1.0 c=1 a=80QVIHGmj5cA:10 a=52mTYfW24d0A:10
 a=IJv9LcIfAAAA:8 a=EVaFm4zkSL5t5EAApi8A:9 a=uTJd3AXS8TNVrThdedYA:7
 a=y7nYJuhOq9R5UeWZh7g-v2y57foA:4 a=K6kUPx8HyhEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119271>

Joe Perches <joe@perches.com> writes:

> Currently the coverletter options for wrapping long lines
> in the shortlog are: on, wrap as position72, with fixed indents.
>
> I think these defaults can produce poor looking output.
>
> This patch allows these to be optionally specified on the
> command line with --cover-letter[=3Dwrap[,pos[,in1[,in2]]]]

I think it makes sense to let users affect how the short-log in the cov=
er
letter is generated.  I do not think overloading the --cover-letter opt=
ion
for doing it is the ideal approach, though.

 - Currently we never generate a cover without being asked, but if we e=
ver
   switch that default in the future, we would want to be able to decli=
ne
   it from the command line with --cover-letter=3Dno (or --no-cover-let=
ter).
   The "no" here is different from "please do not wrap but do produce
   cover letter".

 - Currently there is only one style of cover letter, but people may wa=
nt
   to add a mechanism to let them use different styles that suit their
   project better in the future, and a natural syntax to ask for a
   different style is --cover-letter=3Dstyle, where "style" may be
   "default", "shortlog", or some other token that the user invents.
   --cover-letter=3Dno will still ask to suppress cover letters.

This is a tangent, but I do not think the current cover-letter that use=
s
shortlog matches everybody's needs.  The shortlog format lists commits
grouped by the author and does not number them, and it makes it hard to
match which message in the series corresponds to which entry in the cov=
er
letter, especially when your series have a resend of somebody else's pa=
tch
in it.  I wouldn't be surprised if somebody comes up with a different
style that is based on "git log --reverse --oneline A..B" output (perha=
ps
without the shortened object name part) and name it the "oneline" style=
,
e.g.

    From: Jeff King

    *** BLURB HERE ***
    The following patches do ...

    1/2	parseopt: add OPT_NEGBIT (R=C3=A9ne Scharfe)
    2/2 ls-files: make --no-empty-directory negatable

     Documentation/technical/api-parse-options.txt |    4 +++
     ...
     test-parse-options.c                          |    1 +
     6 files changed, 45 insertions(+), 3 deletions(-)


Now, where does "line wrapping parameters" fit in the picture of this
possible future with multiple styles?  From the implementation convenie=
nce
viewpoint, you could make the line wrapping knobs specific to the
"shortlog" style.  It however is conceivable that "oneline" style (yet =
to
be written by somebody) may want to wrap its output, and the parameters=
 it
would want to use may well be the same set.

I think it would make sense to introduce a separate parameter:

	--cover-letter-wrap=3D<pos>,<indent>,<wrap-offset>

at this point in your patch.  It does not add oneline or any other
different styles, but it would keep the door open for later additions
without breaking the UI.

By the way, don't people find the semantics of in1/in2 to shortlog
wrapping unnatural?  By the above three-tuple parameter, I meant:

	wrap at position [pos], indent the whole thing by this much
	[indent], and offset the second and subsequent lines by this much
	[wrap-offset].

and that reads much better than the -w option of shortlog that says

	wrap at position [pos], indent the whole thing by this much
	[in1], and offset the second and subsequent lines by this much
	[in2 minus in1].
