From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: limit the output of the yes utility
Date: Tue, 2 Feb 2016 09:21:10 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602020907290.2964@virtualbox>
References: <56B05A95.3000808@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 09:21:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQWD8-0003gI-9d
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 09:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbcBBIVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 03:21:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:64783 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031AbcBBIVN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 03:21:13 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Mb7lL-1al5493xQh-00Kj1z; Tue, 02 Feb 2016 09:21:11
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56B05A95.3000808@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:G/37dyGyVD9BQXTb8yejlrJVgmFngTTDds7DzdddYpzef7l35NT
 Jx0weClsThuyMPWiwPEgMVT3ZDfOkDnPriK7oPZmBvHhjjne8UjSAWEtrYcvdB9ae0K99pw
 4MZ7LZGXPLU/e6EKXOQKbbcS0ULLGwSzezNMEmsm/nq9RV9BbZ6IO/6bXBv5+eVmRZ/QyeR
 J/KxEKFzE6/wEvm3Dvqrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5BvJ32ctnS0=:jlTO9MdPGcGFOtMtE5PnTB
 O8GTGd4udeyIqTl93BPVy5GXq6wGtXCmxGER7PWUU1LHIyR8PXHr0GwhEtw36p/AdkJOJwMyM
 Cfe+zPSIBDEWDrvTyQ4BfJzZqQsaixHIJTWKmBaSKEdQ/6ETXgVsiSA25d13KXZ+bP9UIt7qj
 jxSW3Hp4v9yhNd0BoU1lItFGW5UI3L4sC8eNuFaCFDBV9wl1HdygxzNP+7jIw7V0Ze3/DdlDt
 tXiVrc3SfOit7eI3LJxAoEYWUbQsEaq2lUSbBGWomzJRiBkt4OcbJeBev8RlaMnGll1EL8XW0
 MOWv7+G+k5XN1Y8dNNykuYZsFGpl1cZ0S65CC63rmlvzEG3eezQ6oq1bLd5l7DfAvwXj3mDeX
 e7PmMfE8FZoGTQIQ0gvnvEMTWxsvs3ew79SSRaswkTPGmwOvNzsLrNbI1ewDlrfMz+UALbLeU
 TtruCbyh+HP3OYUofJgckiqr6MMw5P1tDcZdVmZH7V8vs+7y6K9DuSIduE5QD5MzZRNy1F/Hp
 /2HNx+0K10X6DEhQQbyRRNPKawJFY/aVDBUO/Ph89226fzzdBb+ZkO3IaKJvmPEnFoG0JMcu/
 HF+Dvz8dXoul8CV3PIaRcGU8fCKJqVHSLMUuSxyYHXK6e7aQtFaMA2Zt3hlqzn3RnFjP27Pa/
 L1F8Ofmws8jBdbcrrq3phWY/fBlcbGmyJoFARpDogxT1yBjT98RmhIC46IEuJRM04EpQlpGNI
 cMG9m8b19MiOQDRys4xq1DRFqL6hbX9kXHPrmocThskjb9RRovAEvnmtfpY0g8QzzuEeBMpD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285243>

Hi Hannes,

On Tue, 2 Feb 2016, Johannes Sixt wrote:

> On Windows, there is no SIGPIPE.

True. But we do get some sort of write failure, no? Otherwise
https://github.com/git/git/commit/2b86292ed would not work...

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index bd4b02e..97e6491 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -902,15 +902,15 @@ fi
>  yes () {
>  	if test $# = 0
>  	then
> -		y=y
> +		set -- y
>  	else
> -		y="$*"
> +		set -- "$*"
>  	fi
> -
> -	while echo "$y"
> -	do
> -		:
> -	done
> +	# we do not need an infinite supply of output for tests
> +	set -- "$@" "$@" "$@" "$@"	# 4
> +	set -- "$@" "$@" "$@" "$@"	# 16
> +	set -- "$@" "$@" "$@" "$@"	# 64
> +	printf "%s\n" "$@"
>  }

I agree with the idea, but I would like to have a less intrusive patch.
Something like this should do the job as well, and is a little easier on
the eyes IMHO:

-- snipsnap --
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 32ac1a6..ae381b9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -907,9 +907,11 @@ yes () {
 		y="$*"
 	fi
 
-	while echo "$y"
+	i=0
+	while test $i -lt 99
 	do
-		:
+		echo "$y"
+		i=$(($i+1))
 	done
 }
 
