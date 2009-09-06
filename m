From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make shallow repository deepening more network efficient
Date: Sat, 05 Sep 2009 22:11:24 -0700
Message-ID: <7vmy58r72b.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.0909031847520.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 06 07:13:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkA4W-00012f-Qo
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 07:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbZIFFLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 01:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbZIFFLf
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 01:11:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbZIFFLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 01:11:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87DAE46385;
	Sun,  6 Sep 2009 01:11:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=erAoeQEQ41n+Rif6dG3XGcV2SlY=; b=FW0nZb
	ZF1bxkQrssemQxN4l2bcBHq1Mope5Z9BWauP4tWYvDcb4QUZLrTI9UX8J/sH9sox
	pCJQCMjuq+H0rnjr+ewpqJBHRhjVik9jKn1oDRwSG+otyyjCJJgCNmn17+qJFFvw
	fDq4q9ftT1CfSVOr9IuihaEU4jJQ8uEqhB4Ck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X+It3mAFwxxqDNpv58P5Y7gdFpI4mghJ
	71v3ReyaINmLiTwvKqreFR9bnmXllNGxN19VUpTXmKmvuslyzvhG3QA8USegBAwR
	/DKCxayR5mUJLrL2KMNNp24rBa5FLSMyEDlaO/5unzyami9ZxVwPCJS+njTqGXmO
	P5VsYs3t5aU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D64646383;
	Sun,  6 Sep 2009 01:11:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8B43C46382; Sun,  6 Sep 2009
 01:11:26 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0909031847520.6044@xanadu.home> (Nicolas
 Pitre's message of "Thu\, 03 Sep 2009 19\:08\:33 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BE74872C-9AA3-11DE-8FE9-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127832>

Nicolas Pitre <nico@cam.org> writes:

> First of all, I can't find any reason why thin pack generation is 
> explicitly disabled when dealing with a shallow repository.  The 
> possible delta base objects are collected from the edge commits which 
> are always obtained through history walking with the same shallow refs 
> as the client, Therefore the client is always going to have those base 
> objects available. So let's remove that restriction.
>
> Then we can make shallow repository deepening much more efficient by 
> using the remote's unshallowed commits as edge commits to get preferred 
> base objects for thin pack generation.  On git.git, this makes the data 
> transfer for the deepening of a shallow repository from depth 1 to depth 2
> around 134 KB instead of 3.68 MB.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>

Dscho, this is your code from around ed09aef (support fetching into a
shallow repository, 2006-10-30) and f53514b (allow deepening of a shallow
repository, 2006-10-30).  The latter disables thin pack transfer but the
log does not attempt to justify the change.

Have any comments?

> diff --git a/upload-pack.c b/upload-pack.c
> index f73e3c9..c77ab71 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -32,6 +32,7 @@ static int no_progress, daemon_mode;
>  static int shallow_nr;
>  static struct object_array have_obj;
>  static struct object_array want_obj;
> +static struct object_array extra_edge_obj;
>  static unsigned int timeout;
>  /* 0 for no sideband,
>   * otherwise maximum packet size (up to 65520 bytes).
> @@ -135,6 +136,10 @@ static int do_rev_list(int fd, void *create_full_pack)
>  	if (prepare_revision_walk(&revs))
>  		die("revision walk setup failed");
>  	mark_edges_uninteresting(revs.commits, &revs, show_edge);
> +	if (use_thin_pack)
> +		for (i = 0; i < extra_edge_obj.nr; i++)
> +			fprintf(pack_pipe, "-%s\n", sha1_to_hex(
> +					extra_edge_obj.objects[i].item->sha1));
>  	traverse_commit_list(&revs, show_commit, show_object, NULL);
>  	fflush(pack_pipe);
>  	fclose(pack_pipe);
> @@ -562,7 +567,6 @@ static void receive_needs(void)
>  		if (!prefixcmp(line, "shallow ")) {
>  			unsigned char sha1[20];
>  			struct object *object;
> -			use_thin_pack = 0;
>  			if (get_sha1(line + 8, sha1))
>  				die("invalid shallow line: %s", line);
>  			object = parse_object(sha1);
> @@ -574,7 +578,6 @@ static void receive_needs(void)
>  		}
>  		if (!prefixcmp(line, "deepen ")) {
>  			char *end;
> -			use_thin_pack = 0;
>  			depth = strtol(line + 7, &end, 0);
>  			if (end == line + 7 || depth <= 0)
>  				die("Invalid deepen: %s", line);
> @@ -657,6 +660,7 @@ static void receive_needs(void)
>  							NULL, &want_obj);
>  					parents = parents->next;
>  				}
> +				add_object_array(object, NULL, &extra_edge_obj);
>  			}
>  			/* make sure commit traversal conforms to client */
>  			register_shallow(object->sha1);
