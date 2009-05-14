From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] improved validation of entry type in mktree
Date: Wed, 13 May 2009 23:24:55 -0700
Message-ID: <7vd4acxkug.fsf@alter.siamese.dyndns.org>
References: <loom.20090514T050424-673@post.gmane.org>
	<loom.20090514T051052-920@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Micich <josh.micich@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 08:25:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4UNO-0003O1-Bq
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 08:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbZENGYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 02:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbZENGYz
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 02:24:55 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:34317 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbZENGYy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 02:24:54 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090514062455.PSQC18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Thu, 14 May 2009 02:24:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id rJQv1b0064aMwMQ04JQv1J; Thu, 14 May 2009 02:24:55 -0400
X-Authority-Analysis: v=1.0 c=1 a=4hqVtUXIpkcA:10 a=V6yvV-yuf1wA:10
 a=pGLkceISAAAA:8 a=8XV-iZI7zbPRnZpdw9MA:9 a=XURpEfDNUMF8DjZh8l8A:7
 a=Z9sqw2AVN0-jl3C9kHS0iqqDCVoA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <loom.20090514T051052-920@post.gmane.org> (Josh Micich's message of "Thu\, 14 May 2009 05\:11\:20 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119147>

Josh Micich <josh.micich@gmail.com> writes:

> diff --git a/builtin-mktree.c b/builtin-mktree.c
> index a56c917..a37954a 100644
> --- a/builtin-mktree.c
> +++ b/builtin-mktree.c
> @@ -71,7 +71,7 @@ static void mktree_line(char *buf, size_t len, int 
> line_termination, int allow_m
>  {
>  	char *ptr, *ntr;
>  	unsigned mode;
> -	enum object_type type;
> +	enum object_type mode_type;

Why?

> @@ -94,29 +94,37 @@ static void mktree_line(char *buf, size_t len, int 
> line_termination, int allow_m
>  	if (S_ISGITLINK(mode))
>  		allow_missing = 1;
>  
> -	if (!allow_missing)
> -		type = sha1_object_info(sha1, NULL);
> -	else
> -		type = object_type(mode);
> -
> -	if (type < 0)
> -		die("object %s unavailable", sha1_to_hex(sha1));
>  
>  	*ntr++ = 0; /* now at the beginning of SHA1 */
> -	if (type != type_from_string(ptr))
> -		die("object type %s mismatch (%s)", ptr, typename(type));
>  
>  	path = ntr + 41;  /* at the beginning of name */
> +	struct strbuf p_uq = STRBUF_INIT;
>  	if (line_termination && path[0] == '"') {
> -		struct strbuf p_uq = STRBUF_INIT;

Why make its lifetime longer even though you do not use it outside of this
block?

> ...
>  	}

> +
> +	mode_type = object_type(mode);
> +	if (mode_type != type_from_string(ptr)) {
> +		die("entry '%s' object type (%s) doesn't match mode type (%s)", 
> path, ptr, typename(mode_type));
> +	}
> +
> +	enum object_type obj_type = sha1_object_info(sha1, NULL);
> +	if (obj_type < 0) {
> +		if (!allow_missing) {

This is the other way around; when allow_missing is given you shouldn't
even consult the object database to read it.
