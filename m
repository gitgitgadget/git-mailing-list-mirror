From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add option --path to allow to run tests with real systems
Date: Wed, 05 Dec 2007 11:32:56 -0800
Message-ID: <7v3auhq6mv.fsf@gitster.siamese.dyndns.org>
References: <20071205134522.GA24617@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 20:33:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izzzs-0006Ik-5N
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbXLETdG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 14:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbXLETdF
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:33:05 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60612 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbXLETdE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 14:33:04 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8203B2FC;
	Wed,  5 Dec 2007 14:33:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E94A9D3F1;
	Wed,  5 Dec 2007 14:33:20 -0500 (EST)
In-Reply-To: <20071205134522.GA24617@laptop> (=?utf-8?B?Tmd1eeG7hW4gVGg=?=
 =?utf-8?B?w6FpIE5n4buNYw==?= Duy's message
	of "Wed, 5 Dec 2007 20:45:22 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67183>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 90b6844..50a3551 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -84,6 +84,8 @@ do
>  	--no-python)
>  		# noop now...
>  		shift ;;
> +	--path=3D*)
> +		path=3D"${1#*=3D}"; shift ;;
>  	*)
>  		break ;;
>  	esac
> @@ -296,11 +298,19 @@ test_done () {
> =20
>  # Test the binaries we have just built.  The tests are kept in
>  # t/ subdirectory and are run in trash subdirectory.
> -PATH=3D$(pwd)/..:$PATH
> -GIT_EXEC_PATH=3D$(pwd)/..
> +if [ -n "$path" ]; then
> +	[ -x "$path/git" ] || error "git not found in $path"
> +	PATH=3D"$path":$PATH
> +	export PATH
> +	GIT_EXEC_PATH=3D"$(git --exec-path)"

This is wrong, isn't it?  $path may point at the freshly built but not
installed git executable, but it reports --exec-path the location that
git-foo and friends are to be _eventually_ installed, not the location
they are sitting after built, being tested, waiting to be installed.
