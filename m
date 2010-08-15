From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] setup.c: Improve 'Not a git repository' messages
Date: Sat, 14 Aug 2010 22:36:40 -0500
Message-ID: <20100815033640.GA20486@burratino>
References: <i43v6e$q00$1@dough.gmane.org>
 <1281840921-1996-1-git-send-email-ralf@ralfebert.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ralf Ebert <ralf@ralfebert.de>
X-From: git-owner@vger.kernel.org Sun Aug 15 05:38:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkU3L-0001su-Sj
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 05:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757995Ab0HODiP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 23:38:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60159 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123Ab0HODiO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 23:38:14 -0400
Received: by iwn7 with SMTP id 7so377195iwn.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 20:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QKUowHNXOTQoCH92nzFzjFLEtBLsCFhyhGs8/gH7fnE=;
        b=Jq/Mpmvl89avMFwU6XaSB8oW5gYkY/uOxxHHyNxR92JRkXXBLmr9StqadPezRcPw6o
         BoVf09mNoOlNxnBXn0hw0kYywev+2EuKM2VHMczbZNLex8S4yfIaXL43AQaa1in5kULB
         CNoIOLOgtlqSW91S7JVSGR6xinXCUL2VPz/7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=o0ZEAj/NyzKuVqDV52CYSg/t8hssVhGDU5Q0QnyfA6tq5Sqi6eEPiYljQ/a2YxwQi5
         k5cGhpGpFYXtzNllXQJdJCwMSQwo9rT1EQsZrStjt0Ah8wwDb3/3bs2FLF0ywReKc1Qz
         KN6VV+uhBw8NE9VcuBDYeXl1SurXCtypSZ1jc=
Received: by 10.231.191.147 with SMTP id dm19mr3793881ibb.6.1281843494169;
        Sat, 14 Aug 2010 20:38:14 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm2958035ibk.15.2010.08.14.20.38.13
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 20:38:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281840921-1996-1-git-send-email-ralf@ralfebert.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153595>

Hi Ralf,

Ralf Ebert wrote:

> +++ b/setup.c
> @@ -431,7 +431,8 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
>  				*nongit_ok =3D 1;
>  				return NULL;
>  			}
> -			die("Not a git repository (or any of the parent directories): %s"=
, DEFAULT_GIT_DIR_ENVIRONMENT);
> +			die("No %s repository in %s or its parent directories",
> +				DEFAULT_GIT_DIR_ENVIRONMENT, cwd);

So, before:

 fatal: Not a git repository (or any of the parent directories): .git

and after:

 fatal: No .git repository in /home/jrn/src/some/deeply/nested/path/tha=
t/goes/on/for/a/while or its parent directories

The idea being to give a hint to the confused user.  That sort of
makes sense, but I would (warning! nitpicks coming!) prefer something
along the lines of

 fatal: not a git repository: /home/jrn/src/some/deeply/nested/pa
 hint: This means every candidate metadata (.git) directory considered
 hint: was invalid in some way.
 hint: See "git help repository-layout" for more information.

In other words:

 - first, a straightforward error message;
 - cutting off user-specified data at some reasonable length
   (e.g. 50 chars);
 - avoiding overly specific (false) advice and deferring to
   documentation for the details.

> @@ -445,9 +446,14 @@ const char *setup_git_directory_gently(int *nong=
it_ok)
>  					*nongit_ok =3D 1;
>  					return NULL;
>  				}
> -				cwd[offset] =3D '\0';
> -				die("Not a git repository (or any parent up to mount parent %s)\=
n"
> -				"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTE=
M not set).", cwd);
> +				const char *home =3D getenv("HOME");
> +				if (home =3D=3D NULL || strncmp(home, cwd, offset) !=3D 0) {
> +					warning("Stopped searching for %s at %.*s "
> +						"as GIT_DISCOVERY_ACROSS_FILESYSTEM is not set",
> +						DEFAULT_GIT_DIR_ENVIRONMENT, offset, cwd);
> +				}
> +				die("No %s repository in %s or its parent directories",
> +					DEFAULT_GIT_DIR_ENVIRONMENT, cwd);

I don=E2=80=99t understand what=E2=80=99s special about $HOME here.

Would something like the following be okay?

 fatal: not a git repository: /home/jrn/src/some/deeply/nested/pa
 info: search stopped at mount parent /home
 hint: This means every candidate metadata (.git) directory considered
 hint: was invalid in some way.
 hint: See "git help repository-layout" for more information.

I actually suspect overriding with $GIT_DISCOVERY_ACROSS_FILESYSTEM
would be kind of rare, so it might be okay to let the documentation
take care of explaining that (provided we include a clear pointer).

Just my two cents.  Feel free to ignore. :)
