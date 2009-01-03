From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsserver: change generation of CVS author names
Date: Sat, 03 Jan 2009 14:14:51 -0800
Message-ID: <7vwsdc3ulg.fsf@gitster.siamese.dyndns.org>
References: <1230910814-32307-1-git-send-email-fabian.emmes@rwth-aachen.de>
 <1230910814-32307-2-git-send-email-fabian.emmes@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Noschinski <lars@public.noschinski.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Martin Langhoff <martin@catalyst.net.nz>
To: Fabian Emmes <fabian.emmes@rwth-aachen.de>
X-From: git-owner@vger.kernel.org Sat Jan 03 23:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJEn9-0003iW-B5
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 23:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759459AbZACWPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 17:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755810AbZACWPE
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 17:15:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbZACWPB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 17:15:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5CEA18D288;
	Sat,  3 Jan 2009 17:14:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1735B8D287; Sat,
  3 Jan 2009 17:14:52 -0500 (EST)
In-Reply-To: <1230910814-32307-2-git-send-email-fabian.emmes@rwth-aachen.de>
 (Fabian Emmes's message of "Fri, 02 Jan 2009 16:40:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F5AF1AEE-D9E3-11DD-850E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104484>

Fabian Emmes <fabian.emmes@rwth-aachen.de> writes:

> CVS username is generated from local part email address.
> We take the whole local part but restrict the character set to the
> Portable Filename Character Set, which is used for Unix login names
> according to Single Unix Specification v3.
>
> Signed-off-by: Fabian Emmes <fabian.emmes@rwth-aachen.de>
> Signed-off-by: Lars Noschinski <lars@public.noschinski.de>

Stating "we should have done this from day one" is one thing (even though
"because some standard says so" is not particularly a good justification
without "and matches the way people use CVS in the real world in practice"
appended to it).

"We should suddenly change the behaviour" is quite a different thing and
it depends on what follows that sentence if the change is justifiable.  We
do not want to hear "...; screw the existing repositories if they have
nonconforming names.".  It is Ok if it is "...; existing repositories will
be affected, but the damage is limited to very minor set of operations,
namely X, Y and Z".

In other words, is there any backward compatibility issue when a
repository that has served existing CVS users and checkouts with older
version switches to the patched one?  If there is one, is that grave
enough that we should care?

>  git-cvsserver.perl |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index cbcaeb4..fef7faf 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -2533,12 +2533,18 @@ sub open_blob_or_die
>      return $fh;
>  }
>  
> -# Generate a CVS author name from Git author information, by taking
> -# the first eight characters of the user part of the email address.
> +# Generate a CVS author name from Git author information, by taking the local
> +# part of the email address and replacing characters not in the Portable
> +# Filename Character Set (see IEEE Std 1003.1-2001, 3.276) by underscores. CVS
> +# Login names are Unix login names, which should be restricted to this
> +# character set.
>  sub cvs_author
>  {
>      my $author_line = shift;
> -    (my $author) = $author_line =~ /<([^>@]{1,8})/;
> +    (my $author) = $author_line =~ /<([^@>]*)/;
> +
> +    $author =~ s/[^-a-zA-Z0-9_.]/_/g;
> +    $author =~ s/^-/_/;
>  
>      $author;
>  }
