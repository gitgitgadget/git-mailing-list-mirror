From: David Rothenberger <daveroth@acm.org>
Subject: Re: [PATCH v3 1/2] Git.pm: add new =?utf-8?b?dGVtcF9pc19sb2NrZWQ=?= function
Date: Thu, 18 Jul 2013 18:34:48 +0000 (UTC)
Message-ID: <loom.20130718T202918-857@post.gmane.org>
References: <1373170849-9150-1-git-send-email-mackyle@gmail.com> <1373170849-9150-2-git-send-email-mackyle@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 20:35:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzt2p-00051v-Pl
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 20:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839Ab3GRSfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 14:35:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:40491 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933420Ab3GRSfI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 14:35:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Uzt2g-0004wj-Ph
	for git@vger.kernel.org; Thu, 18 Jul 2013 20:35:06 +0200
Received: from baradur.entomo.com ([216.34.91.132])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 20:35:06 +0200
Received: from daveroth by baradur.entomo.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 20:35:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 216.34.91.132 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:22.0) Gecko/20100101 Firefox/22.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230721>

Kyle J. McKay <mackyle <at> gmail.com> writes:

> +sub temp_is_locked {
> +	my ($self, $name) = _maybe_self( <at> _);
> +	my $temp_fd = \$TEMP_FILEMAP{$name};
> +
> +	defined $$temp_fd && $$temp_fd->opened && $TEMP_FILES{$$temp_fd}{locked};
> +}
> +
>  =item temp_release ( NAME )
> 
>  =item temp_release ( FILEHANDLE )
>  <at>  <at>  -1248,7 +1277,7  <at>  <at>  sub _temp_cache {
> 
>  	my $temp_fd = \$TEMP_FILEMAP{$name};
>  	if (defined $$temp_fd and $$temp_fd->opened) {
> -		if ($TEMP_FILES{$$temp_fd}{locked}) {
> +		if (temp_is_locked($name)) {
>  			throw Error::Simple("Temp file with moniker '" .
>  				$name . "' already in use");
>  		}

There's a problem with this use of temp_is_locked. There is an else
clause right after this:

	} else {
		if (defined $$temp_fd) {
			# then we're here because of a closed handle.

Prior to the patch, the comment is correct, but after the patch, the
if block may also be entered if the file is open but locked. This is
because temp_is_locked checks that the temp file is defined, open,
and locked.

This issue leads to lots of 

  Temp file 'svn_delta_3360_0' was closed. Opening replacement. 

messages for me.

Reverting the change in _temp_cache solves the problem for me.
Adding an " && !$$temp_fd->opened" clause to the if statement also
works, but this is less efficient.
