From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] templates/Makefile: work around SGI install which
 assumes / if ROOT not defined
Date: Mon, 18 Aug 2008 16:37:12 -0700
Message-ID: <7vhc9hlwt3.fsf@gitster.siamese.dyndns.org>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil> <XAO6w2f4AxtqGEL6HNTkRYjhSFFUavQK8LYfdASEGw3-LRoH4_7Cdg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Gerrit Pape <pape@smarden.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:38:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEIq-0002JJ-Lp
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbYHRXhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753272AbYHRXhV
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:37:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbYHRXhU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:37:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 37E1453621;
	Mon, 18 Aug 2008 19:37:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 78349535FD; Mon, 18 Aug 2008 19:37:14 -0400 (EDT)
In-Reply-To: <XAO6w2f4AxtqGEL6HNTkRYjhSFFUavQK8LYfdASEGw3-LRoH4_7Cdg@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon, 18 Aug 2008 18:14:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 987607A6-6D7E-11DD-825F-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92762>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> diff --git a/templates/Makefile b/templates/Makefile
> index 9f3f1fc..3ea63e1 100644
> --- a/templates/Makefile
> +++ b/templates/Makefile
> @@ -29,7 +29,7 @@ boilerplates.made : $(bpsrc)
>  		case "$$boilerplate" in *~) continue ;; esac && \
>  		dst=`echo "$$boilerplate" | sed -e 's|^this|.|;s|--|/|g'` && \
>  		dir=`expr "$$dst" : '\(.*\)/'` && \
> -		$(INSTALL) -d -m 755 blt/$$dir && \
> +		ROOT=./ $(INSTALL) -d -m 755 blt/$$dir && \

I do not see absolutely any reason to use install there.

I have to wonder why 9907721 (templates/Makefile: don't depend on local
umask setting, 2008-02-28) did not do this instead:

	$(QUIET)umask 022 && ls *--* 2>/dev/null | \
	while read boilerplate; \
	do \
		case "$$boilerplate" in *~) continue ;; esac && \
		dst=`echo "$$boilerplate" | sed -e 's|^this|.|;s|--|/|g'` && \
		dir=`expr "$$dst" : '\(.*\)/'` && \
		mkdir -p blt/$$dir && \
		case "$$boilerplate" in \
		*--) ;; \
		*) cp $$boilerplate blt/$$dst ;; \
		esac || exit; \
	done && \
	date >$@
