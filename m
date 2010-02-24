From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 3/3] fallback SSH_ASKPASS when GIT_ASKPASS not set
Date: Wed, 24 Feb 2010 16:34:57 +0100
Message-ID: <40aa078e1002240734u1ef6364fp16fbce50caf575bd@mail.gmail.com>
References: <1267024554-3288-1-git-send-email-lznuaa@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 19:03:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nki3l-0001hh-9u
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 19:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933166Ab0BYSDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2010 13:03:30 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47732 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933000Ab0BYSD3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2010 13:03:29 -0500
Received: by wya21 with SMTP id 21so2007392wya.19
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 10:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=08JoitjOqLtqwmcUFXw25HMDDDrN3NJSZGCzBwDyN9U=;
        b=GMpAzSc77J2W2dSTMeAQdJRyuURvLcSFS4f1zgKk28etAWBEMK9T+P1AY2IprNuk3D
         FO+W8Jb6fhoX6kp6uiomIlMa+5DmJHzl/Jy5MIP8voj2HFRlby081DG1brHSCzZWvWMx
         wTJf2GEah4i3wmoA+x2vEFusyR5pJ1jXqcgvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=E/CyNUGY26BpO32SVr7EWln8fSeCUQYuB0YHTFYRMci0oU0o1j//AjsH37U6UCIyTi
         VA0e7Ykm1P2XbByDUFNLC6pC1Kb3bXvtr6YxuFhvj2xi93KEhLubqLsq/TjjidXXuUOR
         dMBLgwTIlQKSTILQlQ6N7x1vc0GGKSSFy+91U=
Received: by 10.216.87.7 with SMTP id x7mr1864563wee.53.1267025697326; Wed, 24 
	Feb 2010 07:34:57 -0800 (PST)
In-Reply-To: <1267024554-3288-1-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141059>

On Wed, Feb 24, 2010 at 4:15 PM, Frank Li <lznuaa@gmail.com> wrote:
> If GIT_ASKPASS is not set and SSH_ASKPASS set, GIT_ASKPASS will
> use SSH_ASKPASS. If GIT_ASKPASS set and SSH_ASKPASS is not set,
> SSH_ASKPASS will use GIT_ASKPASS.
>

Since there's a maximum total size of the environment on Windows
(64kib), perhaps it's better to not increase the environment-size more
than necessary and instead check both variables when used? I must
admit doing so gives me a kind of yuck-feeling, but at least it should
also make non-builtins (like git-svn, which AFAICT is what you're
fixing) work consistently even if it's not called through the
git-wrapper...

> Signed-off-by: Frank Li <lznuaa@gmail.com>
> ---
> =A0git.c | =A0 =A05 +++++
> =A01 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/git.c b/git.c
> index 90c6daf..39e1eba 100644
> --- a/git.c
> +++ b/git.c
> @@ -54,6 +54,11 @@ static int handle_options(const char ***argv, int =
*argc, int *envchanged)
> =A0{
> =A0 =A0 =A0 =A0int handled =3D 0;
>
> + =A0 =A0 =A0 if (getenv("GIT_ASKPASS") && !getenv("SSH_ASKPASS"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setenv("SSH_ASKPASS", getenv("GIT_ASKPA=
SS"), 1);
> + =A0 =A0 =A0 if (!getenv("GIT_ASKPASS") && getenv("SSH_ASKPASS"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setenv("GIT_ASKPASS", getenv("SSH_ASKPA=
SS"), 1);
> +
> =A0 =A0 =A0 =A0while (*argc > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *cmd =3D (*argv)[0];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cmd[0] !=3D '-')
> --
> 1.7.0.85.g37fda.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Erik "kusma" Faye-Lund
