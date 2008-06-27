From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit-tree: lift completely arbitrary limit of 16
 parents
Date: Fri, 27 Jun 2008 10:16:27 -0700
Message-ID: <7v7icassr8.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806262243130.2988@localhost.localdomain>
 <alpine.DEB.1.00.0806271259440.9925@racer>
 <alpine.DEB.1.00.0806271324010.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Len Brown <lenb@kernel.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:17:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCHZm-0000Vy-DH
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbYF0RQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbYF0RQi
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:16:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbYF0RQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:16:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B5889AF8;
	Fri, 27 Jun 2008 13:16:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 96EA89AF6; Fri, 27 Jun 2008 13:16:29 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806271324010.9925@racer> (Johannes
 Schindelin's message of "Fri, 27 Jun 2008 13:24:47 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CA58D338-446C-11DD-81BD-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86604>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> -static int new_parent(int idx)
> +static void new_parent(struct commit *parent, struct commit_list **parents_p)
>  {
> -	int i;
> -	unsigned char *sha1 = parent_sha1[idx];
> -	for (i = 0; i < idx; i++) {
> -		if (!hashcmp(parent_sha1[i], sha1)) {
> +	unsigned char *sha1 = parent->object.sha1;
> +	struct commit_list *parents;
> +	for (parents = *parents_p; parents; parents = parents->next) {
> +		if (!hashcmp(parents->item->object.sha1, sha1)) {

Wouldn't it be enough to compare (parents->item == parent)?

> @@ -69,18 +63,16 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
>  
>  	check_valid(tree_sha1, OBJ_TREE);
>  	for (i = 2; i < argc; i += 2) {
> +		unsigned char sha1[40];

s/4/2/;
