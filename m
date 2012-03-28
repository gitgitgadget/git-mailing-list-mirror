From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Wed, 28 Mar 2012 12:28:10 -0700
Message-ID: <7viphov839.fsf@alter.siamese.dyndns.org>
References: <1332962282-4040-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	hellmuth@ira.uka.de
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:28:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCyXf-0007dE-3G
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044Ab2C1T2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:28:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757996Ab2C1T2N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 15:28:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C86576D9;
	Wed, 28 Mar 2012 15:28:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PVra5+9wYElbrMLEIVo49Cm85+A=; b=rf26An
	QIJIT4BeHHQPEKdmuxUIZA9o3ED5TVYKY25yCRCbo2s6x0NU9r8U93n4uUmNnjNU
	3teCnD3Rcd+xPsmV39CB1QO2UM4T5zD8fIIlh0lnZO0z5YlKhclPLwa2X3Vo9dzM
	cRdb83V8kpK86l6X98euvZcqRwPKW2nPeB3d4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cXfx3nir3n5aDFdmi2/dpr/UuX/qv390
	D3HvlaVP9crk1AUoLA3DalOJES9mBLCTaeiYffo1NF3BCJqbjiRdJPxyNUg2zhk/
	JB4LHELONEsgY0CrJdv4qMJxxKR0lv7nNtegGpoX7cm1FKDaHarCbSo2gk0iyM/K
	zvAos3jJIj8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83B4A76D8;
	Wed, 28 Mar 2012 15:28:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14CCA76D7; Wed, 28 Mar 2012
 15:28:11 -0400 (EDT)
In-Reply-To: <1332962282-4040-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Wed, 28 Mar 2012 21:18:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2853A9F4-790C-11E1-BFC7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194169>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 8f0839d..a52507f 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1259,6 +1259,13 @@ sub patch_update_file {
>  	my $quit = 0;
>  	my ($ix, $num);
>  	my $path = shift;
> +
> +	# skip conflicted paths
> +	if (run_cmd_pipe(qw(git ls-files -u --), $path)) {
> +		print colored $error_color, "Warning: $path is in conflicted state, skipping.\n";
> +		return 0;
> +	}
> +

Thanks.

I have to wonder if the filtering should go to much higher level in the
callchain.

Perhaps teach list_modified(), which currently takes 'file-only' and
'index-only', to also take an option to omit (and warn if it is
appropriate) unmerged paths?
