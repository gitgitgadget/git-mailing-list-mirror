From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Reuse previous annotation when overwriting a tag
Date: Sat, 03 Nov 2007 11:47:44 -0700
Message-ID: <7vlk9fxj1r.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711031219530.4362@racer.site>
	<1194095285-18651-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 19:48:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoO2U-0000bN-MF
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 19:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbXKCSry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755232AbXKCSry
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 14:47:54 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:36951 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173AbXKCSrx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 14:47:53 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9C99E2EF;
	Sat,  3 Nov 2007 14:48:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 12DFA91C95;
	Sat,  3 Nov 2007 14:48:11 -0400 (EDT)
In-Reply-To: <1194095285-18651-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Sat, 3 Nov 2007 14:08:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63298>

Mike Hommey <mh@glandium.org> writes:

> +static void write_tag_body(int fd, const unsigned char *sha1)
> +{
> ...
> +	sp = buf = read_sha1_file(sha1, &type, &size);
> +	if (!buf)
> +		return;
> +	/* skip header */
> +	sp = strstr(buf, "\n\n");

I was relieved to see this second assignment to "sp" here.

Why?

Because I wanted to say something about the first assignment to
it, that is done this way:

> +	sp = buf = read_sha1_file(sha1, &type, &size);

The original git codebase, as it came from Linus, tends to avoid
assignment to multiple variables in a single statement like this
(and that style is written down in the kernel coding style
document).  As I do not have a strong opinion against that
coding style, I've tried to follow it myself.  However, I do not
personaly have a strong argument to support enforcing the style
to others.

But in this case, as the variable "sp" is never used before it
is reassigned, I can easily say "drop the useless assignment to
sp there". ;-)

> +
> +	if (!sp || !size || type != OBJ_TAG) {
> +		free(buf);
> +		return;
> +	}
> +	sp += 2; /* skip the 2 CRs */

You are not skipping carriage returns.  You are skipping line
feeds (i.e. s/CRs/LFs/).

> @@ -282,7 +313,11 @@ static void create_tag(const unsigned char *object, const char *tag,
>  		if (fd < 0)
>  			die("could not create file '%s': %s",
>  						path, strerror(errno));
> -		write_or_die(fd, tag_template, strlen(tag_template));
> +
> +		if (prev)
> +			write_tag_body(fd, prev);
> +		else
> +			write_or_die(fd, tag_template, strlen(tag_template));
>  		close(fd);

When prev is not NULL but points at a null_sha1 nobody writes
anything out.  Is this intended?

        In fact, the calling site always passes prev which is
        prev[] in cmd_tag() and cannot be non-NULL.

Why is there "else" in the first place?  Even if you start with
the previous tag's message, you are launching the editor for the
user to further edit it, and you would want to give some
instructions, wouldn't you?
        
