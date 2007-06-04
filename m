From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 3/6] git-fsck: Do thorough verification of tag objects.
Date: Mon, 4 Jun 2007 07:56:55 +0200
Message-ID: <20070604055655.GB15148@moooo.ath.cx>
References: <200706040251.05286.johan@herland.net> <200706040251.52613.johan@herland.net> <200706040253.51920.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 07:57:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv5Yt-0008As-Lu
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 07:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbXFDF47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 01:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbXFDF47
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 01:56:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:59893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751900AbXFDF46 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 01:56:58 -0400
Received: (qmail invoked by alias); 04 Jun 2007 05:56:56 -0000
Received: from pd9ebb5ac.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.172]
  by mail.gmx.net (mp018) with SMTP; 04 Jun 2007 07:56:56 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18abwxhp3saczJGa+0b9E7vBDBMuDP2Iz+5Qx9tdV
	COHO+2bMf/WecZ
Content-Disposition: inline
In-Reply-To: <200706040253.51920.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49065>

Johan Herland <johan@herland.net> wrote:
> diff --git a/builtin-fsck.c b/builtin-fsck.c
> index cbbcaf0..a8914ae 100644
> --- a/builtin-fsck.c
> +++ b/builtin-fsck.c
> @@ -344,6 +344,20 @@ static int fsck_commit(struct commit *commit)
>  static int fsck_tag(struct tag *tag)
>  {
>  	struct object *tagged = tag->tagged;
> +	enum object_type type;
> +	unsigned long size;
> +	char *data = (char *) read_sha1_file(tag->object.sha1, &type, &size);
> +	if (!data)
> +		return error("Could not read tag %s", sha1_to_hex(tag->object.sha1));
> +	if (type != OBJ_TAG) {
> +		free(data);
> +		return error("Internal error: Tag %s not a tag", sha1_to_hex(tag->object.sha1));
> +	}
> +	if (parse_and_verify_tag_buffer(0, data, size, 1)) { /* Thoroughly verify tag object */
> +		free(data);
> +		return error("Tag %s failed thorough tag object verification", sha1_to_hex(tag->object.sha1));
> +	}
> +	free(data);
>  
>  	if (!tagged) {
>  		return objerror(&tag->object, "could not load tagged object");

The objerror() function prints the sha1 and object type, I think this
one should be used instead of error() here.
