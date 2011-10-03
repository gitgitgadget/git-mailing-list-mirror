From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] ident: check /etc/mailname if email is unknown
Date: Sun, 02 Oct 2011 22:30:31 -0700
Message-ID: <7v8vp2iqvc.fsf@alter.siamese.dyndns.org>
References: <20111003045745.GA17604@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matt Kraai <kraai@ftbfs.org>,
	Gerrit Pape <pape@smarden.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 07:30:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAb6u-00050t-Qi
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 07:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab1JCFag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 01:30:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755045Ab1JCFae (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 01:30:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A47DA26F4;
	Mon,  3 Oct 2011 01:30:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rkSUvrdXT22y1eNOxtjaPEW0NeM=; b=dtDMqJ
	VpqLOz4pYWGr2ofQ7tIw/RMPeI348XPUn40ybMOlnWlnvfRPzQs9kaR4dt2PQ5EO
	Bi2HK574PoV9qt7Fl6OjfrqTTenA7Bb41h252BhhSjcCL6agIpDVaPHFqX+SfOLV
	5qUFthO1AhTdgEveMwWzEMahkz/j1gQdfnXVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=olWog9G6IRb52nSb7Pw2m7WYwRdiV2sD
	DJThd4i0OfN7BbDNNAuGm7/shxkE/Fc2IZqgEK1l/phKFZExhFk+4xbaEWjJlFO0
	VJn87n0DJ5aUDkaDj6CKvZZxYpjZl53yn9Oto2hoA2rLyCOToQu5AnKK3vbAu5E3
	zyB77G3OsA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B62E26F3;
	Mon,  3 Oct 2011 01:30:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C34426F0; Mon,  3 Oct 2011
 01:30:33 -0400 (EDT)
In-Reply-To: <20111003045745.GA17604@elie> (Jonathan Nieder's message of
 "Sun, 2 Oct 2011 23:57:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D08C2C9E-ED80-11E0-A133-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182623>

Jonathan Nieder <jrnieder@gmail.com> writes:

> @@ -52,6 +52,8 @@ static void copy_gecos(const struct passwd *w, char *name, size_t sz)
>  
>  static void copy_email(const struct passwd *pw)
>  {
> +	FILE *mailname;
> +
>  	/*
>  	 * Make up a fake email address
>  	 * (name + '@' + hostname [+ '.' + domainname])
> @@ -61,6 +63,27 @@ static void copy_email(const struct passwd *pw)
>  		die("Your sysadmin must hate you!");
>  	memcpy(git_default_email, pw->pw_name, len);
>  	git_default_email[len++] = '@';
> +
> +	/*
> +	 * The domain part comes from /etc/mailname if it is readable,
> +	 * or the current hostname and domain name otherwise.
> +	 */
> +	mailname = fopen("/etc/mailname", "r");
> +	if (!mailname) {
> +		if (errno != ENOENT)
> +			warning("cannot open /etc/mailname: %s",
> +				strerror(errno));
> +	} else if (fgets(git_default_email + len,
> +			 sizeof(git_default_email) - len, mailname)) {
> +		/* success! */
> +		fclose(mailname);
> +		return;
> +	} else {
> +		if (ferror(mailname))
> +			warning("cannot read /etc/mailname: %s",
> +				strerror(errno));
> +		fclose(mailname);
> +	}
>  	gethostname(git_default_email + len, sizeof(git_default_email) - len);
>  	if (!strchr(git_default_email+len, '.')) {
>  		struct hostent *he = gethostbyname(git_default_email + len);

I do not think this would hurt, even though I see /etc/mailname on only
one of my boxes (i.e. Debian). For maintainability for the future,
however, I would prefer to see the above hunk separated into a helper
function to keep addition to copy_email() to the minimum, e.g.

	memcpy(git_default_email, pw->pw_name, len);
        git_default_email[len++] = '@';

+	if (add_mailname_host(git_default_email, len, sizeof(git_default_email)))
+		return; /* read from "/etc/mailname" (Debian) */

	gethostname(git_default_email + len, sizeof(git_default_email) - len);
        ...

So that people who care about other distros can more easily add a single
implementation to a similar location without making copy_email() too long
to lose clarity. The fallback default logic that does gethostname() might
also want to become a separate helper function as well.
