From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [bug] generic issue with git_config handlers
Date: Thu, 7 Feb 2008 06:45:23 +0100
Message-ID: <200802070645.23840.chriscool@tuxfamily.org>
References: <20080131091627.GB24403@artemis.madism.org> <200802050013.20335.chriscool@tuxfamily.org> <7vk5lki815.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 06:39:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMzUM-0002Sf-CT
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 06:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbYBGFjY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2008 00:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbYBGFjY
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 00:39:24 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:41267 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbYBGFjX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2008 00:39:23 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5ED5C1AB2C5;
	Thu,  7 Feb 2008 06:39:22 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3C8071AB2B5;
	Thu,  7 Feb 2008 06:39:22 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vk5lki815.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72895>

Le mardi 5 f=E9vrier 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Very unfortunate.
> >
> > I finally had the following patch that passed all tests (it changed
> > only one test), in case someone wants to suggest that we change
> > git_config_bool, hint, hint!
>
> Sorry, I do not get what you are hinting at.=20

Well, I wanted someone else to suggest that we deprecate using "" as a=20
boolean false.

Something like this (completely untested) :

diff --git a/config.c b/config.c
index 526a3f4..44afeaa 100644
--- a/config.c
+++ b/config.c
@@ -300,8 +300,19 @@ int git_config_bool(const char *name, const char=20
*value)
 {
        if (!value)
                return 1;
-       if (!*value)
+       if (!*value) {
+               fprintf(stderr,
+                       "Warning: using an empty value for boolean conf=
ig "
+                       "variables is deprecated.\n"
+                       "An empty value currently means 'false' as a "
+                       "boolean, but may very well means 'true' in the=
 "
+                       "future!\n"
+                       "Please consider using a 'false' value explicit=
ely "
+                       "for variable '%s', so that your config is futu=
re "
+                       "proof. You can do that using:\n"
+                       "\tgit config %s false\n", name, name)
                return 0;
+       }
        if (!strcasecmp(value, "true") || !strcasecmp(value, "yes"))
                return 1;
        if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))

So that in a future version we can use "" internaly for both no value a=
nd=20
empty value variables and consider them meaning the same.

> The fact that you
> passed all the tests suggests that we have a gap in the test
> coverage for these two, so you are inviting more tests from
> others?

I just sent a patch to close this gap.

[...]

> Your "builtin-config.c" patch looks better than before (which
> would segfault), but I think
>
> 	$ git config --bool --list
>
> could pay attention to the "type" thing set earlier, just like
> show_config() does.

I didn't try this, but I will.

Thanks,
Christian.
