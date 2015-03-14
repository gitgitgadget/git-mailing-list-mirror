From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/GSoC/RFC] fetch: git fetch --deepen
Date: Fri, 13 Mar 2015 22:35:38 -0700
Message-ID: <xmqqlhj0xhsl.fsf@gitster.dls.corp.google.com>
References: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 06:35:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWejh-0008Qg-Ot
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 06:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbbCNFfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 01:35:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751038AbbCNFfk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 01:35:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2203A34257;
	Sat, 14 Mar 2015 01:35:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7yRttgrfvft6239WI07fEbeU9lE=; b=eFYWz9
	y2u95KiZbRE5Rrj3+kj53Ewkm/xs4LxpNmJUU36gI9+551lc+GyMa+g+5Z4QlW9J
	wCNhp1pNpt56akormTKSzOpwg1DA6Cbfb4HLB/mBQ70ZyG7H+4mQz6gnE/p3iLkI
	1pYqjTebLbyXUuaEVZaNmg+5GF8w+JnoH5VdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DT8q3CdWclo9iRyORxS0S/PMDKUaSW21
	AKV0ewLK6nLicutbqYb77OGhsEsukNjrMin00pEnFDt4BDcMFfrmqtnaxaH2Zeeo
	3zhTzIyURavlaoecryaVTlU9ROa/FrEo2c3WWoGkTO8piGEXFpkruj40e1bU9bh9
	CEb9CtJzhQQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1ADC734256;
	Sat, 14 Mar 2015 01:35:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 712BC34255;
	Sat, 14 Mar 2015 01:35:39 -0400 (EDT)
In-Reply-To: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com>
	(Dongcan Jiang's message of "Fri, 13 Mar 2015 21:04:06 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F2CAC746-CA0B-11E4-B0A3-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265437>

Dongcan Jiang <dongcan.jiang@gmail.com> writes:

> This patch is just for discusstion. An option --deepen is added to
> 'git fetch'. When it comes to '--deepen', git should fetch N more
> commits ahead the local shallow commit, where N is indicated by
> '--depth=N'. [1]
>
> e.g.
>
>>  (upstream)
>>   ---o---o---o---A---B
>>
>>  (you)
>>                  A---B
>
> After excuting "git fetch --depth=1 --deepen", (you) get one more
> tip and it becomes
>
>>  (you)
>>              o---A---B
>
> '--deepen' is designed to be a boolean option in this patch, which
> is a little different from [1]. It's designed in this way, because
> it can reuse '--depth' in the program, and just costs one more bit
> in some data structure, such as fetch_pack_args,
> git_transport_options.
>
> Of course, as a patch for discussion, it remains a long way to go
> before being complete.
>
> 	1) Documents should be completed.
> 	2) More test cases, expecially corner cases, should be added.
> 	3) No need to get remote refs when it comes to '--deepen' option.
> 	4) Validity on options combination should be checked.
> 	5) smart-http protocol remains to be supported. [2]
>
> Besides, I still have one question:
> What does (you) exactly mean in [1]? The local branch or the local
> remote ref?

As this operation is not about moving _any_ refs, whether local
branches or remote-tracking branches, any ref that used to point at
commit B before you executed "fetch --deepen" would point at the
same commit after the command finishes.

The "you" does not explicitly depict any ref, because the picture is
meant to illustrate _everything_ the repository at the receiving end
of "fetch" has.  It used to have two commits, A and B (and the tree
and blob objects necessary to complete these two commits).  After
deepening the history by one commit, it then will have commit A^ and
its trees and blobs.

> diff --git a/upload-pack.c b/upload-pack.c
> index b531a32..8004f2f 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -31,6 +31,7 @@ static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<
>
>  static unsigned long oldest_have;
>
> +static int depth_deepen;
>  static int multi_ack;
>  static int no_done;
>  static int use_thin_pack, use_ofs_delta, use_include_tag;
> @@ -563,11 +564,11 @@ static void receive_needs(void)
>  			}
>  			continue;
>  		}
> -		if (starts_with(line, "deepen ")) {
> +		if (starts_with(line, "depth ")) {
>  			char *end;
> -			depth = strtol(line + 7, &end, 0);
> -			if (end == line + 7 || depth <= 0)
> -				die("Invalid deepen: %s", line);
> +			depth = strtol(line + 6, &end, 0);
> +			if (end == line + 6 || depth <= 0)
> +				die("Invalid depth: %s", line);
>  			continue;
>  		}
>  		if (!starts_with(line, "want ") ||

I do not quite understand this hunk.  What happens when this program
is talking to an existing fetch-pack that requested "deepen"?

> @@ -577,6 +578,8 @@ static void receive_needs(void)
>
>  		features = line + 45;
>
> +		if (parse_feature_request(features, "depth_deepen"))
> +			depth_deepen = 1;
>  		if (parse_feature_request(features, "multi_ack_detailed"))
>  			multi_ack = 2;
>  		else if (parse_feature_request(features, "multi_ack"))
> @@ -631,6 +634,10 @@ static void receive_needs(void)
>  				struct object *object = shallows.objects[i].item;
>  				object->flags |= NOT_SHALLOW;
>  			}
> +		else if (depth_deepen)
> +			backup = result =
> +				get_shallow_commits(&shallows, depth + 1,
> +						    SHALLOW, NOT_SHALLOW);
>  		else
>  			backup = result =
>  				get_shallow_commits(&want_obj, depth,
> --
> 2.3.1.253.gb3fd89e
