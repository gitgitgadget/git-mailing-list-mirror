From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix recursive-merge of empty files with different
 permissions
Date: Thu, 13 Mar 2008 11:50:08 -0700
Message-ID: <7vabl2xxun.fsf@gitster.siamese.dyndns.org>
References: <20080308171726.GA16129@localhost>
 <alpine.LSU.1.00.0803081850470.3975@racer.site>
 <20080313125229.GA24758@localhost>
 <alpine.LSU.1.00.0803131607030.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 19:51:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZsW9-0000UI-Ui
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 19:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbYCMSu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 14:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753949AbYCMSu1
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 14:50:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbYCMSu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 14:50:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D9A9419B2;
	Thu, 13 Mar 2008 14:50:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0AEC619A0; Thu, 13 Mar 2008 14:50:19 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77127>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/builtin-merge-file.c b/builtin-merge-file.c
> index adce6d4..cde4b2c 100644
> --- a/builtin-merge-file.c
> +++ b/builtin-merge-file.c
> @@ -57,7 +57,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
>  
>  		if (!f)
>  			ret = error("Could not open %s for writing", filename);
> -		else if (fwrite(result.ptr, result.size, 1, f) != 1)
> +		else if (result.size &&
> +				fwrite(result.ptr, result.size, 1, f) != 1)
>  			ret = error("Could not write to %s", filename);
>  		else if (fclose(f))
>  			ret = error("Could not close %s", filename);

Lol.  We are dealing with N-byte quantity so we send one record of length
N and make sure we processed one record, and it does not work when N is
zero.

We could instead send N records of size 1 and make sure we processed N
records to lose the conditional instead, but the patch avoids unnecessary
call to fread/fwrite so that is good.  Thanks.

It felt funny because my current bedtime reading happens to be "Zero: The
Biography of a Dangerous Idea (ISBN 0140296476)".

> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index bba2364..61dc5c5 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -152,8 +152,8 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
>  	if ((f = fopen(filename, "rb")) == NULL)
>  		return error("Could not open %s", filename);
>  	sz = xsize_t(st.st_size);
> -	ptr->ptr = xmalloc(sz);
> -	if (fread(ptr->ptr, sz, 1, f) != 1)
> +	ptr->ptr = xmalloc(sz ? sz : 1);
> +	if (sz && fread(ptr->ptr, sz, 1, f) != 1)
>  		return error("Could not read %s", filename);
>  	fclose(f);
>  	ptr->size = sz;

Do you need to actually allocate ptr->ptr when sz is zero, instead of
setting it to NULL, like:

	sz = xsize_t(st.st_size);
	ptr->size = sz;
        if (!sz)
        	ptr->ptr = NULL;
	else {
        	ptr->ptr = xmalloc(sz);
		if (fread(ptr->ptr, 1, sz, f) != sz)
			return error("Could not read %s", filename);
	}
	fclose(f);
