From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/2] remote-curl.c: fix rpc_out()
Date: Tue, 24 Nov 2009 01:54:15 +0800
Message-ID: <20091124015415.c22d07c1.rctay89@gmail.com>
References: <20091123110338.2b230359.rctay89@gmail.com>
	<fabb9a1e0911222153n633ade94w179513d4aa42a3d4@mail.gmail.com>
	<be6fef0d0911230038y13c23e3ek5591ee0dc3eaa47a@mail.gmail.com>
	<alpine.DEB.1.00.0911231137170.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 23 18:54:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCd7X-0000Dk-6Q
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 18:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbZKWRy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 12:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbZKWRy1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 12:54:27 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:65257 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbZKWRy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 12:54:26 -0500
Received: by bwz23 with SMTP id 23so5472103bwz.29
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 09:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ztSLHjwUk5qQreb2HsTE9ZYBdmtDVZpmAQWJhfK+HlM=;
        b=Vbobfz7UxPpbaaVPnOs+NUg3zhzlCKC9NLaQypZA+fXvsqik7zQjNMDgHK8OWg5TiX
         iJv9KQtiZZfIzfMqdU/3COF64L0r7ViVlKynoVw41LX31gWmRF26FQnlHgKtG+UJ9dgb
         QG9LXSk9U9GLGohHovEqM3n8xB3HyNvTZSiBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=Yn83HylGb+TcOcYO4pcoJquHf305xjtCEOB0eSJVXLWTWBquhYi02oSZCqLhOOnoGx
         k48LxwIgVMO+s4ohrfpr1OrjjASOcKGZhjTAvcI6xPxK9fqWCktgp1DQOOh+AbPyUZX2
         UPn12mgskrNVjJ+X93nD3K3mL3J6Br+EgGmVY=
Received: by 10.204.148.85 with SMTP id o21mr4700489bkv.134.1258998871723;
        Mon, 23 Nov 2009 09:54:31 -0800 (PST)
Received: from your-cukc5e3z5n (cm164.zeta152.maxonline.com.sg [116.87.152.164])
        by mx.google.com with ESMTPS id c28sm6032243fka.49.2009.11.23.09.54.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 09:54:30 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0911231137170.4985@pacific.mpi-cbg.de>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133516>

Hi,

On Mon, Nov 23, 2009 at 6:39 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I guess you meant "not be enough", as an int can hold a pretty large
> number until it turns negative.

I really did mean 'enough' - enough to trigger the use of chunked
encoding. I think the most important fix here is forcing rpc_out to
(according to curl) memcpy at most size_t max bytes (the removal of the
extraneous ';' addresses this). Pushing with chunked transfer would
fail with this extra semicolon.

Removing the possibility of a negative size_t was a preventive measure,
and, like you mentioned, requires a larger repository, so it's harder
to test for.

I probably should separate these issues into separate patches.

> So I think in this case it is more harm- than helpful to have a test case.
>
> For future reference: if you need a repository with special featurs
> for testing, it is best to generate it in a test script (see the many test
> cases labeled 'setup' in our test suite for examples).

Here's what I came up with: use the git repository which fetched the
test suite, and use the environment variable GIT_REMOTE_REFSPEC to specify
the remote refspec which the tester fetches git from.


  if test -z "$GIT_REMOTE_REFSPEC"; then
  	say 'skipping test, the remote for git is not specified'
  else
  	test_expect_success 'push with chunked encoding' '
  		OWD=$(pwd) &&
  		cd $TEST_DIRECTORY/../.git/ &&
  		REPO=$(pwd) &&
  		cd "$OWD" &&
  		echo "$REPO"/objects > .git/objects/info/alternates &&
  		git fetch "$REPO" "$GIT_REMOTE_REFSPEC"/*:refs/remotes/git/* &&
  		git push -v -v origin "refs/remotes/git/*:refs/remotes/git/*" \
  			>out 2>&1 &&
  		grep "POST git-receive-pack (chunked)" out
  	'
  fi

Thoughts?

-- 
Cheers,
Ray Chuan
