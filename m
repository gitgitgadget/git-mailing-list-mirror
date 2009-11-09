From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (Nov 2009, #02; Sun, 08)
Date: Mon, 9 Nov 2009 07:29:35 -0800
Message-ID: <20091109152935.GM11919@spearce.org>
References: <7vzl6wz36r.fsf@alter.siamese.dyndns.org> <905315640911090008h34b55a37q439d02de37127039@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 16:29:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7WBb-0001gj-KG
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 16:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094AbZKIP3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 10:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbZKIP3a
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 10:29:30 -0500
Received: from george.spearce.org ([209.20.77.23]:34995 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064AbZKIP3a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 10:29:30 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6E751381FC; Mon,  9 Nov 2009 15:29:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <905315640911090008h34b55a37q439d02de37127039@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132487>

Tarmigan <tarmigan+git@gmail.com> wrote:
> On Sun, Nov 8, 2009 at 9:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > * sp/smart-http (2009-11-04) 30 commits
> >  + test smart http fetch and push
> 
> I am trying to test smart http, and have had to set
> DEFAULT_HTTPD_PATH='/usr/sbin/httpd'
> DEFAULT_HTTPD_MODULE_PATH='/usr/lib64/httpd/modules' on Centos.
> Perhaps this failing test is just a difference in the default Apache
> and curl configurations.

*sigh*
 
> --- exp	2009-11-09 07:33:19.000000000 +0000
> +++ act	2009-11-09 07:33:19.000000000 +0000
> @@ -6,15 +6,16 @@
>  < Pragma: no-cache
>  < Cache-Control: no-cache, max-age=0, must-revalidate
>  < Content-Type: application/x-git-upload-pack-advertisement
> -<
>  > POST /smart/repo.git/git-upload-pack HTTP/1.1
> +> Accept: */*
>  > Accept-Encoding: deflate, gzip
>  > Content-Type: application/x-git-upload-pack-request
>  > Accept: application/x-git-upload-pack-response

The first delta is a missing blank line between requests.  I probably
can work around that with some sort of sed hackery and its likely
caused by a different libcurl version.

The second delta is libcurl sending *two* Accept headers to the
server.  The first was set by the library as "*/*", but the second
was set by git-remote-curl.  Here your libcurl is just plain *wrong*.
The application has said "I only support one content type, this one"
and the library still went and told the server "I accept anything
you have, just give it to me!".

I'm not sure what to do about this breakage in curl.  We may have
to relax how we use HTTP since at least one version of libcurl
can't get this minor detail right.

>  > Content-Length: xxx
> 
> +> 0073want 1937bb05802e1973cc2e437c13e9f1845941b785
> multi_ack_detailed side-band-64k thin-pack no-progress ofs-delta
> +> 00000009done

Hmmph.  Your libcurl also included the POST body in the verbose
message.

-- 
Shawn.
