From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Make git-fmt-merge-msg a builtin
Date: Mon, 3 Jul 2006 17:17:51 +0300
Message-ID: <20060703171751.2ed33220.tihirvon@gmail.com>
References: <Pine.LNX.4.63.0607031530380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jul 03 16:17:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxPFL-00056g-Bl
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 16:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWGCORv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 10:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWGCORv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 10:17:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:11922 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751179AbWGCORu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 10:17:50 -0400
Received: by nf-out-0910.google.com with SMTP id k26so430572nfc
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 07:17:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=WZRIYK2Ppd4n08REpoSk4sdjkvc+hmQwnw4sR4pJEIjOQYJtG9JEq2jr414RxT/jbgPj/GDQpG1BA6PUXRmntLBgZKth6A7mnFmsmbOr48i/3H+85OpaxzqXCoXINH8GwQn4Uho9ozkjtzjTMQTZAWP3SJ6E7dn8KK5GMe9xy5o=
Received: by 10.48.233.18 with SMTP id f18mr2451086nfh;
        Mon, 03 Jul 2006 07:17:49 -0700 (PDT)
Received: from garlic.home.net ( [82.128.203.109])
        by mx.gmail.com with ESMTP id c1sm4577204nfe.2006.07.03.07.17.48;
        Mon, 03 Jul 2006 07:17:49 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607031530380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.19; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23178>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> +struct list {
> +	char **list;
> +	void **payload;
> +	unsigned nr, alloc;
> +};

How about something like this instead to reduce mallocs to half and
simplify the code?

struct item {
	char *value;
	void *payload;
};

struct list {
	struct item *items;
	unsigned int nr, alloc;
};

(But I realize this isn't performance critical)

> +static void append_to_list(struct list *list, char *value)

Add void *payload parameter too, would simplify the code.

> +static void free_list(struct list *list)
> +{
> +	int i;
> +
> +	if (list->alloc == 0)
> +		return;

Unnecessary if nr is 0 too.

> +	for (i = 0; i < list->nr; i++) {
> +		free(list->list[i]);
> +		if (list->payload[i])
> +			free(list->payload[i]);

free(NULL) is safe.

> +	}
> +	free(list->list);
> +	free(list->payload);
> +	list->nr = list->alloc = 0;
> +}

> +	if (!strncmp(line, "branch ", 7)) {
> +		origin = strdup(line + 7);
> +		append_to_list(&(src_data->branch), origin);

Parenthesis isn't needed.

> +	head->object.flags |= UNINTERESTING;
> +        prepare_revision_walk(rev);

Spaces..

> +	if (merge_summary) {
> +		struct commit *head;
> +		struct rev_info rev;
> +
> +		head = lookup_commit(head_sha1);
> +parse_object(head->object.sha1);
> +head = head->parents->item;

Indentation.

-- 
http://onion.dynserv.net/~timo/
