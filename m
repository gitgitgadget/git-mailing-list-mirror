From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] git-svn: workaround for a bug in svn serf backend
Date: Mon, 30 Dec 2013 13:20:30 +0100
Message-ID: <87lhz2o7ht.fsf@thomasrast.ch>
References: <87ha9wdh8g.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
	<1388059524-4864-1-git-send-email-rkagan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Benjamin Pabst <benjamin.pabst85@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Roman Kagan <rkagan@mail.ru>
X-From: git-owner@vger.kernel.org Mon Dec 30 13:20:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxbq2-0002tw-Gs
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 13:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706Ab3L3MUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 07:20:50 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:47379 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755672Ab3L3MUt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 07:20:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id E3D154D6510;
	Mon, 30 Dec 2013 13:20:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GNCoL6faWFHi; Mon, 30 Dec 2013 13:20:36 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id CCFAB4D64BD;
	Mon, 30 Dec 2013 13:20:35 +0100 (CET)
In-Reply-To: <1388059524-4864-1-git-send-email-rkagan@mail.ru> (Roman Kagan's
	message of "Thu, 26 Dec 2013 16:05:24 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239801>

Roman Kagan <rkagan@mail.ru> writes:

> +	# workaround for a bug in svn serf backend (v1.8.5 and below):
> +	# store 3d argument to ->add_file() in a local variable, to make it
> +	# have the same lifetime as $fbat
> +	my $upa = $self->url_path($m->{file_a});
>  	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
> -				$self->url_path($m->{file_a}), $self->{r});
> +				$upa, $self->{r});

Hmm, now that you put it that way, I wonder if the patch is correct.

Let me first rephrase the problem to verify that I understand the issue:

  $fbat keeps a pointer to the $upa string, without maintaining a
  reference to it.  When $fbat is destroyed, it needs this string, so we
  must ensure that the lifetime of $upa is at least as long as that of
  $fbat.

However, does Perl make any guarantees as to the order in which local
variables are unreferenced and then destroyed?  I can't find any such
guarantee.

In the absence of such, wouldn't we have to keep $upa in an outer,
separate scope to ensure that $fbat is destroyed first?

-- 
Thomas Rast
tr@thomasrast.ch
