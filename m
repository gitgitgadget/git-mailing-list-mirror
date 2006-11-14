X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] allow deepening of a shallow repository
Date: Mon, 13 Nov 2006 23:24:53 -0800
Message-ID: <7vy7qeze0q.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0610302009390.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 07:25:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31338>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjsfD-0001dU-Qw for gcvg-git@gmane.org; Tue, 14 Nov
 2006 08:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933239AbWKNHYz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 02:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933240AbWKNHYz
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 02:24:55 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:39619 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S933239AbWKNHYy
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 02:24:54 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114072454.WQAX20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 02:24:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mXR01V0091kojtg0000000; Tue, 14 Nov 2006
 02:25:00 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, by saying "git fetch -depth <n> <repo>" you can deepen
> a shallow repository.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  commit.c      |   13 +++++++++++++
>  commit.h      |    3 ++-
>  fetch-pack.c  |   22 ++++++++++++++++------
>  git-fetch.sh  |   12 +++++++++++-
>  shallow.c     |    8 ++++++--
>  upload-pack.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++-----------
> diff --git a/upload-pack.c b/upload-pack.c
> index ebe1e5a..162dd34 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -134,6 +134,7 @@ static void create_pack_file(void)
>  		} else {
>  			for (i = 0; i < want_obj.nr; i++) {
>  				struct object *o = want_obj.objects[i].item;
> +				o->flags &= ~UNINTERESTING;
>  				add_pending_object(&revs, o, NULL);
>  			}
>  			for (i = 0; i < have_obj.nr; i++) {

I am puzzled why this is needed in this series.  In other words,
do we have a bug in the current upload-pack that does not have
shallow already by not clearing UNINTERESTING bit?  In yet other
words, I haven't figured out which part of the shallow series
makes it necessary to clear UNINTERESTING bit from wanted
object.

> @@ -547,23 +554,51 @@ static void receive_needs(void)
>...
> +		for (i = 0; i < shallows.nr; i++) {
> +			struct object *object = shallows.objects[i].item;
> +			if (object->flags & NOT_SHALLOW) {
> +				struct commit_list *parents;
> +				packet_write(1, "unshallow %s",
> +					sha1_to_hex(object->sha1));
> +				object->flags &= ~CLIENT_SHALLOW;
> +				/* make sure the real parents are parsed */
> +				unregister_shallow(object->sha1);
> +				parse_commit((struct commit *)object);
> +				parents = ((struct commit *)object)->parents;
> +				while (parents) {
> +					add_object_array(&parents->item->object,
> +							NULL, &want_obj);
> +					parents = parents->next;
> +				}
> +			}

I doubt unregister_shallow() is enough to ensure that the next
parse_commit() re-parses to recover its parents.  parse_commit()
says "if (item->object.parsed) return 0" upfront.  Don't you
need to do:

	object->parsed = 0;

before parse_commit()?
