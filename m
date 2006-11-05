X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Remove unsupported C99 style struct initializers in git-archive.
Date: Sat, 04 Nov 2006 23:32:32 -0800
Message-ID: <7vd582uz5b.fsf@assigned-by-dhcp.cox.net>
References: <20061105053723.GC4193@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 07:32:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061105053723.GC4193@spearce.org> (Shawn O. Pearce's message of
	"Sun, 5 Nov 2006 00:37:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30956>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgcUf-00086F-J5 for gcvg-git@gmane.org; Sun, 05 Nov
 2006 08:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161208AbWKEHce (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 02:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161209AbWKEHce
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 02:32:34 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:45742 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1161208AbWKEHcd
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 02:32:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061105073232.QSVT18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Sun, 5
 Nov 2006 02:32:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ivYd1V00X1kojtg0000000 Sun, 05 Nov 2006
 02:32:38 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

"Shawn O. Pearce" <spearce@spearce.org> writes:

> +static struct archiver_desc
> +{
> +	const char *name;
> +	write_archive_fn_t write_archive;
> +	parse_extra_args_fn_t parse_extra;
> +} archivers[] = {
> +	{ "tar", write_tar_archive, NULL },
> +	{ "zip", write_zip_archive, parse_extra_zip_args },
>  };

If this were a struct with bazillions of fields I might have had
trouble swallowing the change, but this is so small that it is
no brainer.

I think this actually is an improvement.

>  static int run_remote_archiver(const char *remote, int argc,
> @@ -88,7 +86,10 @@ static int init_archiver(const char *nam
>  
>  	for (i = 0; i < ARRAY_SIZE(archivers); i++) {
>  		if (!strcmp(name, archivers[i].name)) {
> -			memcpy(ar, &archivers[i], sizeof(struct archiver));
> +			memset(ar, 0, sizeof(*ar));
> +			ar->name = archivers[i].name;
> +			ar->write_archive = archivers[i].write_archive;
> +			ar->parse_extra = archivers[i].parse_extra;

But is this change really needed?  Shouldn't a structure
assignment just work?
