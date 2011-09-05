From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] push: old receive-pack does not understand --quiet
Date: Sun, 04 Sep 2011 19:28:38 -0700
Message-ID: <7vy5y3yb6x.fsf@alter.siamese.dyndns.org>
References: <20110903105723.GA16304@tin.tmux.org>
 <1315067656-2846-1-git-send-email-drizzd@aon.at>
 <1315067656-2846-4-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tobiasu@tmux.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 05 04:28:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0OvX-0005qr-Hc
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 04:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166Ab1IEC2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 22:28:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37710 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab1IEC2k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 22:28:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AF6C45FA;
	Sun,  4 Sep 2011 22:28:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oXzq7WZUqbbY6eDW/wuicNsis3g=; b=G5eRuz
	74gc3rXLPsb7dsfAjVk0b7vdM7xG3pAb/N6G36YMofC8etgaUaoSn14CTEd0fei2
	K1a3JJmrunEMjNd4g4yD0h2wzkSB7nTQcZ07fPO9bcSUsLz30YP3QWaS7KU1PTT0
	85RoeZxSKTz7JDp87hAsrPfm+Fw14qeSSOHSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eFGgcQ/cLfot5S5tqJlbbEMvMn/o+5VK
	NtXB2pnhel5EhPKHCpRjnX66ZrzZ77OjogjGU+OIsiX3TMf9rNdytG1FAoZewhFw
	FwaDoOkahOsMjuRtG9NLHOKS+bwSfrH1vu8xChIWEVCXmaVCp4/cyOzH0M5fAeBA
	ARKZnJdikbc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42F0B45F9;
	Sun,  4 Sep 2011 22:28:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD37645F8; Sun,  4 Sep 2011
 22:28:39 -0400 (EDT)
In-Reply-To: <1315067656-2846-4-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Sat, 3 Sep 2011 18:34:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4250546-D766-11E0-B4D6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180712>

Clemens Buchacher <drizzd@aon.at> writes:

> @@ -114,7 +115,7 @@ static int show_ref(const char *path, const unsigned char *sha1, int flag, void
>  	else
>  		packet_write(1, "%s %s%c%s%s\n",
>  			     sha1_to_hex(sha1), path, 0,
> -			     " report-status delete-refs side-band-64k",
> +			     " report-status delete-refs side-band-64k quiet",
>  			     prefer_ofs_delta ? " ofs-delta" : "");
>  	sent_capabilities = 1;
>  	return 0;
> @@ -636,6 +637,8 @@ static struct command *read_head_info(void)
>  				report_status = 1;
>  			if (strstr(refname + reflen + 1, "side-band-64k"))
>  				use_sideband = LARGE_PACKET_MAX;
> +			if (strstr(refname + reflen + 1, "quiet"))
> +				quiet = 1;

Side note.

We may want to make sure that this is not part of a different token word
(if we knew better, we would have written the other side so that we can
just test against " quiet ", but that is not possible, sigh...).

>  		}
>  		cmd = xcalloc(1, sizeof(struct command) + len - 80);
>  		hashcpy(cmd->old_sha1, old_sha1);
> @@ -669,7 +672,7 @@ static const char *parse_pack_header(struct pack_header *hdr)
>  
>  static const char *pack_lockfile;
>  
> -static const char *unpack(int quiet)
> +static const char *unpack()

I'll amend this as "static const char *unpack(void)" while applying.
