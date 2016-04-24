From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] fast-import: implement unpack limit
Date: Sun, 24 Apr 2016 12:18:08 -0700
Message-ID: <xmqqpoten7db.fsf@gitster.mtv.corp.google.com>
References: <20160423024225.GA4293@dcvr.yhbt.net>
	<20160423031313.GA15043@sigill.intra.peff.net>
	<20160424043223.GA27609@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Apr 24 21:18:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auPXv-00062f-4o
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 21:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbcDXTSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 15:18:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752071AbcDXTSL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 15:18:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 362BC16ED5;
	Sun, 24 Apr 2016 15:18:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZGSXasPpzHTFbEbDEeVoFdmmvAM=; b=JwWDa7
	v/kVsG1MDGXionIM+8Rt2TrJB5mXYATgHdZUcddrwez3bZ5iOTf+lYsyD/A915v3
	N0d4iqT4EJAUF0zTSyQixlVo98KHoRwN/RAoVKYcfsrtkRf2pS0zVbajqInU/660
	oDbRCOOn5+XYLRF4iTd11x00yrdQOEkek33vU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DsISKmpRaoR7E5frndFotAIdNC7kLnkG
	IbiAZc6jEjSR+qwFU2/r9ZKu+5CgFSenKETvBW8CVRg7+ljh6BAa2fhaDYQIncjl
	OS9zS4iQRbJMtL5QQ2D73TnYMHZz4dQ6juP7apEMnwi3UkU5XJ9KmQJu4KEOpXrI
	8Jd9vQCgEC8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AF1516ED4;
	Sun, 24 Apr 2016 15:18:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FF6A16ED3;
	Sun, 24 Apr 2016 15:18:09 -0400 (EDT)
In-Reply-To: <20160424043223.GA27609@dcvr.yhbt.net> (Eric Wong's message of
	"Sun, 24 Apr 2016 04:32:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 47D7F6EC-0A51-11E6-A8C1-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292432>

Eric Wong <normalperson@yhbt.net> writes:

> +static int loosen_small_pack(const struct packed_git *p)
> +{
> +	struct child_process unpack = CHILD_PROCESS_INIT;
> +
> +	if (lseek(p->pack_fd, 0, SEEK_SET) < 0)
> +		die_errno("Failed seeking to start of '%s'", p->pack_name);
> +
> +	unpack.in = p->pack_fd;
> +	unpack.git_cmd = 1;
> +	unpack.stdout_to_stderr = 1;
> +	argv_array_push(&unpack.args, "unpack-objects");
> +	argv_array_push(&unpack.args, "-q");
> +
> +	return run_command(&unpack);
> +}

So you have fd open to a *.pack file you have been writing, you are
going to close and discard it after you return from here, so you
just seek the fd to the beginning and hand it to unpack-objects.

And this works if you haven't finalized the *.pack file with the
corresponding *.idx (otherwise unpack-objects would silently ignore
objects found in the *.idx file); and obviously you haven't and you
are not going to create *.idx file for this.

Looks good.  I haven't thought if "-q" is appropriate or not though.

> @@ -972,6 +990,12 @@ static void end_packfile(void)
>  		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
>  				    pack_data->pack_name, object_count,
>  				    cur_pack_sha1, pack_size);
> +
> +		if (object_count <= unpack_limit) {
> +			if (loosen_small_pack(pack_data) == 0)
> +				goto discard_pack;
> +		}

"if (!loosen_small_pack(pack_data))" would be more idiomatic, but
the logic is very clear here.  We haven't created the idx, we skip
the part that creates the idx and instead jump directly to the part
that closes and unlinks it.

I like this change.  Thanks.

>  		close(pack_data->pack_fd);
>  		idx_name = keep_pack(create_index());
>  
> @@ -1002,6 +1026,7 @@ static void end_packfile(void)
>  		pack_id++;
>  	}
>  	else {
> +discard_pack:
>  		close(pack_data->pack_fd);
>  		unlink_or_warn(pack_data->pack_name);
>  	}
