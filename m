From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT GUI PATCH 1/2] git-gui: teach _which procedure to work with
 absolute paths
Date: Fri, 23 Mar 2012 12:31:03 -0700
Message-ID: <7v8virt8qw.fsf@alter.siamese.dyndns.org>
References: <cover.1332523097.git.hvoigt@hvoigt.net>
 <e7a733b5ad4e2009aec205235a95a610ee18947b.1332523097.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 20:31:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBACe-0004NM-JS
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 20:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759475Ab2CWTbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 15:31:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34486 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758262Ab2CWTbF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 15:31:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BBD6614E;
	Fri, 23 Mar 2012 15:31:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qfol+w5CooSMVLOpdF8zGETcEAY=; b=nb0xAZ
	JCXP4mM7emHQS1RmGBGZWPKgA/gm+Dyr340SD0xnYGXWuJ4ITEVYWCLD8Xg+NNDI
	DeFK5yuE74PEePV8YPeRdoTyPHtoHwy921/NbjfFV6lNTykWE3FTlA6SNNKnM7OO
	T7HzdMUFAXdZhDpnxxyolcwEFw8OirfNIHnSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C2aNIwUa6AoYoOWuZNUGFaKXtZlK2N7f
	a7QdS7VP9+UvobebzrSZn18NB3yGFztKJhv/n/7BqAv3a1g8WCeSAg12t2CI6EDz
	5czIvMZ3MLiMtweWd2emJmejLAAXF+ZNCCmXxf0x+dpgtwfw5j6BTSWvfSY6h2+Y
	WXeUHY0f28I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22E6D6143;
	Fri, 23 Mar 2012 15:31:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1E3B6142; Fri, 23 Mar 2012
 15:31:04 -0400 (EDT)
In-Reply-To: <e7a733b5ad4e2009aec205235a95a610ee18947b.1332523097.git.hvoigt@hvoigt.net>
 (Heiko Voigt's message of "Fri, 23 Mar 2012 18:30:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB202498-751E-11E1-B412-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193796>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> _which is useful to check whether a certain command can be called.
> Previously when given an absolute path it would not recognize it as
> an existing program. Lets change that so it transparently handles such
> cases.
>
> Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
> ---
>  git-gui/git-gui.sh |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index ba4e5c1..35cdee8 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -429,6 +429,10 @@ proc _git_cmd {name} {
>  proc _which {what args} {
>  	global env _search_exe _search_path
>  
> +	if {[file exists $what]} {
> +		return [file normalize $what]
> +	}

Has $what been verified that it is either an absolute path, or contains a
directory separator, at this point in the code?

Otherwise, "_which Makefile" would say "Yeah, that is the one I will
launch" in a directory that has a "Makefile" even when the user does not
have "." in his $PATH, no?

>  	if {$_search_path eq {}} {
>  		if {[is_Cygwin] && [regexp {^(/|\.:)} $env(PATH)]} {
>  			set _search_path [split [exec cygpath \
