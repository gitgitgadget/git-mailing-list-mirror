From: Jeff King <peff@peff.net>
Subject: Re: error: git-remote-https died of signal 13
Date: Mon, 25 Nov 2013 01:39:45 -0500
Message-ID: <20131125063945.GA16313@sigill.intra.peff.net>
References: <5290D994.9040505@googlemail.com>
 <20131124065400.GB5535@sigill.intra.peff.net>
 <5291F70A.7070508@googlemail.com>
 <20131124133356.GA3507@sigill.intra.peff.net>
 <529214D7.1030203@googlemail.com>
 <20131124155439.GA8047@sigill.intra.peff.net>
 <52922A22.2090109@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 07:39:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vkppn-0006ax-QL
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 07:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab3KYGjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 01:39:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:45153 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751037Ab3KYGjr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 01:39:47 -0500
Received: (qmail 21146 invoked by uid 102); 25 Nov 2013 06:39:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Nov 2013 00:39:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Nov 2013 01:39:45 -0500
Content-Disposition: inline
In-Reply-To: <52922A22.2090109@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238301>

On Sun, Nov 24, 2013 at 05:32:34PM +0100, Stefan Beller wrote:

> GIT_TRANSPORT_HELPER_DEBUG=1 git clone https://github.com/Bertram25/ValyriaTear.git
> now ends with:
> 
> Debug: Remote helper: Waiting...
> remote: Counting objects: 21354, done.
> remote: Compressing objects: 100% (6249/6249), done.
> remote: Total 21354 (delta 16466), reused 19888 (delta 15066)
> Receiving objects: 100% (21354/21354), 176.42 MiB | 1.22 MiB/s, done.
> Resolving deltas: 100% (16466/16466), done.
> Debug: Remote helper: <- lock /tmp/ValyriaTear/.git/objects/pack/pack-b6f360ab28b5078a9aefafe1c4144e6c7782c317.keep
> Debug: Remote helper: Waiting...
> Debug: Remote helper: <- connectivity-ok
> Debug: Remote helper: Waiting...
> Debug: Remote helper: <- 
> Checking connectivity... done.
> Debug: Disconnecting.
> warning: in http_cleanup
> warning: calling curl_multi_remove_handle
> warning: calling curl_easy_cleanup on slot
> warning: curl_easy_cleanup done
> warning: calling curl_easy_cleanup on default
> warning: curl_easy_cleanup done
> warning: calling curl_multi_cleanup
> error: git-remote-https died of signal 13

Thanks. I'm having trouble reproducing the SIGPIPE locally, but I am
able to see via strace the write we make in curl_multi_cleanup. The
call stack is:

  curl_multi_cleanup
    -> close_all_connections
      -> Curl_disconnect
        -> Curl_ossl_close
          ...

Daniel, does the call to Curl_disconnect need to be wrapped with
sigpipe_ignore/reset, similar to 7d80ed64e435155?

-Peff
