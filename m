From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] gitweb: remove unnecessary test when closing file
 descriptor
Date: Tue, 04 Jan 2011 16:15:58 -0800
Message-ID: <7vaajgdx35.fsf@alter.siamese.dyndns.org>
References: <1293744031-17790-1-git-send-email-sylvain@abstraction.fr>
 <1293744031-17790-3-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Wed Jan 05 01:16:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaH30-000620-Oc
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 01:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259Ab1AEAQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 19:16:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab1AEAQI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 19:16:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3AB923A51;
	Tue,  4 Jan 2011 19:16:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/nE9IfDj9m/S/7/ABHaQzt1Gm0Y=; b=qutheD
	WowHF/h0MZmZDwrw1Xb56h7b1eow93GWNu27yhkv1/3BJ3p7wG4fr0MechWzJo83
	pn2L12gtw4wYRxdQWlUrPEc5K0NPWbMFep03lgVXQlT5TXKBW53sb7mQqh8pn1lx
	BowUmNCX7IS0QvEoNkOZusq+dqVL2vjFyYxqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iG968OeO0GwmaAust21NmS185zRc1Ut3
	sWqHFaGwVUGjU3q2l+IyonPzRlF1Seo1gOd5G1USMZauN66sib593cah3BunZBfz
	/7DCpbLyZo9mTaZA50ODLlkz9VMQeb5HQpHfNkhAwgqcTiGHAYSuJ2msfXN14qIo
	+P07C9U1boU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 185433A50;
	Tue,  4 Jan 2011 19:16:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ED0713A4F; Tue,  4 Jan 2011
 19:16:37 -0500 (EST)
In-Reply-To: <1293744031-17790-3-git-send-email-sylvain@abstraction.fr>
 (Sylvain Rabot's message of "Thu\, 30 Dec 2010 22\:20\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 11CC5508-1861-11E0-8D90-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164530>

Sylvain Rabot <sylvain@abstraction.fr> writes:

> it happens that closing file descriptor fails whereas
> the blob is perfectly readable. According to perlman
> the reasons could be:
>
>    If the file handle came from a piped open, "close" will additionally
>    return false if one of the other system calls involved fails, or if the
>    program exits with non-zero status.  (If the only problem was that the
>    program exited non-zero, $! will be set to 0.)  Closing a pipe also waits
>    for the process executing on the pipe to complete, in case you want to
>    look at the output of the pipe afterwards, and implicitly puts the exit
>    status value of that command into $?.
>
>    Prematurely closing the read end of a pipe (i.e. before the process writ-
>    ing to it at the other end has closed it) will result in a SIGPIPE being
>    delivered to the writer.  If the other end can't handle that, be sure to
>    read all the data before closing the pipe.
>
> In this case we don't mind that close fails.
>
> Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>

Hmm, do you want a few helped-by lines here?

I'll queue this to 'pu', but only because I do not care too much about
this part of the codepath, not because I think this is explained well.

For example, what does "the reasons could be" mean?  If the reasons turned
out to be totally different, that would make this patch useless?  IOW, is
it fixing the real issue?  Without knowing the reasons, how can we
conclude that "In this case" we don't mind?

Having said all that, I agree that you are seeing a failure exactly
because of the reason you stated above with an unnecessary weak "could
be".  A filehandle to a pipe to cat-file is opened by the caller of
blob_mimetype(), it gets peeked at with -T inside the function, then it
gets peeked at with -B inside the caller (by the way, didn't anybody find
this sloppy?  Why isn't blob_mimetype() doing all of that itself?), and
then after that the run_highligher closes the filehandle, because it does
not want to read from the unadorned cat-file output at all.  Of course,
cat-file may receive SIGPIPE if we do that, and we know we don't care how
cat-file died in that particular case.

But do we care if the first cat-file died due to some other reason?  Is
there anything that catches the failure mode?

> ---
>  gitweb/gitweb.perl |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ea984b9..eae75ac 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3465,8 +3465,7 @@ sub run_highlighter {
>  	my ($fd, $highlight, $syntax) = @_;
>  	return $fd unless ($highlight && defined $syntax);
>  
> -	close $fd
> -		or die_error(404, "Reading blob failed");
> +	close $fd;
>  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
>  	          quote_command($highlight_bin).
>  	          " --xhtml --fragment --syntax $syntax |"
> -- 
> 1.7.3.4.523.g72f0d.dirty
