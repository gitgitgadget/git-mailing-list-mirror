From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Respect definition of prefix from autotools in
 ETC_GITCONFIG and ETC_GITATTRIBUTES
Date: Thu, 28 Apr 2011 09:54:02 -0700
Message-ID: <7v62py5nbp.fsf@alter.siamese.dyndns.org>
References: <20110428022922.GC4833@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kacper Kornet <kornet@camk.edu.pl>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:54:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFUTr-00073C-OK
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 18:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321Ab1D1QyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 12:54:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab1D1QyN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 12:54:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C204F582B;
	Thu, 28 Apr 2011 12:56:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N0sE9QsgBHOTY+I5cR+rGbEWPAA=; b=nyUxGM
	9gn3jJLf3a1An/k11V+1OFKubkiAonegLljgN418oCQRS/yRa4N2V1jstRxiIAi+
	WVl4644WC1tnZBWUNnctV7tFPyijhgxBhkck5ectbbgU+8zXpJxUsC/dRPRpYW2O
	fS5rKqb+kI5HOQgGeTzriC0eVtL+W0MSnEdyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z7MBKEcOjDFIbSLxtaME1vOGqUlSPZVs
	qlKvrnTyLpBKRdxtTRD3FRGas9YT3ORPZGcwewsl4Ativrgd8D1Vtrhi+kgTCERL
	//pnOptrMtwbx5mAfKP9Hga7Qt0ObjpKT01yufwcBVdHHS1JNFGyMhJCk0R/fGUv
	odK76CDw5h0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E5945827;
	Thu, 28 Apr 2011 12:56:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AC3E85826; Thu, 28 Apr 2011
 12:56:07 -0400 (EDT)
In-Reply-To: <20110428022922.GC4833@camk.edu.pl> (Kacper Kornet's message of
 "Thu, 28 Apr 2011 04:29:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B172A6A-71B8-11E0-BEC4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172376>

Kacper Kornet <kornet@camk.edu.pl> writes:

> Definitions of ETC_GITCONFIG and ETC_GITATTRIBUTES depend on value of
> prefix. As prefix can be changed in config.mak.autogen, all if blocks
> with conditions based on prefix should be placed after the file is
> included in Makefile.

This is _not_ just about autogen, is it?  The same issue exists if the
user wants to manually tweak prefix in config.mak, no?

If so, perhaps the patch needs to be retitled to avoid confusion,
something like:

    Subject: Honor $(prefix) set in config.mak* when defining ETC_GIT* variables

> diff --git a/Makefile b/Makefile
> index cbc3fce..5b4ae40 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -291,15 +291,8 @@ sharedir = $(prefix)/share
>  gitwebdir = $(sharedir)/gitweb
>  template_dir = share/git-core/templates
>  htmldir = share/doc/git-doc
> -ifeq ($(prefix),/usr)
> -sysconfdir = /etc
>  ETC_GITCONFIG = $(sysconfdir)/gitconfig
>  ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
> -else
> -sysconfdir = $(prefix)/etc
> -ETC_GITCONFIG = etc/gitconfig
> -ETC_GITATTRIBUTES = etc/gitattributes
> -endif
>  lib = lib
>  # DESTDIR=
>  pathsep = :
> @@ -1192,6 +1185,12 @@ endif
>  -include config.mak.autogen
>  -include config.mak
>  
> +ifeq ($(prefix),/usr)
> +sysconfdir = /etc
> +else
> +sysconfdir = etc
> +endif

It makes sense to change the definition of ETC_GIT* variables to a form
that depends on a variable like your patch did, i.e.

    ETC_GITCONFIG = $(some_etc_prefix)/gitconfig
    ETC_GITATTRIBUTES = $(some_etc_prefix)/gitattributes

and define that variable, whose definition depends on $(prefix), after we
have read config.mak* files.  So I like the general direction of this
patch.

But this part in the Makefile outside the context of the patch bothers
me.  It seems to imply that sysconfdir is _not_ that variable you want to
define later.

   # Among the variables below, these:
   #   gitexecdir
   #   template_dir
   #   mandir
   #   infodir
   #   htmldir
   #   ETC_GITCONFIG (but not sysconfdir)
   #   ETC_GITATTRIBUTES
   # can be specified as a relative path some/where/else;

So I have a suspicion that your patch as is will break when prefix is set
to something other than /usr directory.  I don't think anybody in-tree
currently uses sysconfdir, but that does not mean nobody will ever do.
