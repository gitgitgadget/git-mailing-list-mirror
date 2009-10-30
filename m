From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC PATCH v4 26/26] test smart http fetch and push
Date: Sat, 31 Oct 2009 00:10:45 +0800
Message-ID: <be6fef0d0910300910x5e8bc552k4f020ca8bb890352@mail.gmail.com>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
	 <1256774448-7625-27-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 17:10:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3u3w-0007aR-VS
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 17:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbZJ3QKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbZJ3QKl
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 12:10:41 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:58024 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbZJ3QKk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 12:10:40 -0400
Received: by mail-iw0-f180.google.com with SMTP id 10so2230238iwn.4
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=CPfB0r0x9wSEMdJvxq91oLYUM/JQVsdcJt0/OpNvtyQ=;
        b=EMP2eJIilgtnZjj4LHUH38nR9656pBYKSbD9D1uON07OdCTkH6xlsNIvqeLE3GIvv8
         YM5kpzgBRX4ATnlh2AOzcTGbFqYBZdUA/Ok3LP2GpkfVIFKckVgGkJKIQVStTn1k8JzB
         dIgNrD8kKe51VlWTsNfiNcLbWccpD1FhcqW3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=QCfUvI5pbz9xb1AU67uaLQHVHVYBc7ENuyTC7fTv+jRhWqQazxzwlUvD/Zw1UJt3Cs
         lVqxDnkhNXNPunBU9aklChhOk65yRih8eLSAImch9pxJA5pyrXbEeeDbpseajYNng1fC
         DJ+1CgCmaXUUzFAsVxl5+O5WXnwa7CeR/HyzY=
Received: by 10.231.9.33 with SMTP id j33mr1469969ibj.37.1256919045825; Fri, 
	30 Oct 2009 09:10:45 -0700 (PDT)
In-Reply-To: <1256774448-7625-27-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131714>

Hi,

On Thu, Oct 29, 2009 at 8:00 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> The top level directory "/git/" of the test Apache server is mapped
> through our git-http-backend CGI, but uses the same underlying
> repository space as the server's document root.  This is the most
> simple installation possible.

Having "/git/" reside as a subdirectory in "/" where WebDAV is enabled
may be confusing to readers. I think we should use "/smart/" for the
CGI map, and consequently, use "/dumb/" for WebDAV repositories,
rather than the root "/" that it is occupying.

> diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
>[snip]
> +test_expect_success 'push to remote repository with packed refs' '
> +       cd "$ROOT_PATH"/test_repo_clone &&
> +       : >path2 &&
> +       git add path2 &&
> +       test_tick &&
> +       git commit -m path2 &&
> +       HEAD=$(git rev-parse --verify HEAD) &&
> +       git push &&
> +       (cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
> +        test $HEAD = $(git rev-parse --verify HEAD))
> +'
> +
> +test_expect_success 'push already up-to-date' '
> +       git push
> +'
> +
> +test_expect_success 'push to remote repository with unpacked refs' '
> +       (cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
> +        rm packed-refs &&
> +        git update-ref refs/heads/master $ORIG_HEAD) &&
> +       git push &&
> +       (cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
> +        test $HEAD = $(git rev-parse --verify HEAD))
> +'

Mention of "packed refs" should be removed from the description, and
the 'unpacked refs' test, irrelevant in this context, should be
removed too. The assumptions these tests are based on is relevant to
t5540, but not in t5541. My explanation follows.

(Clemens, the following also addresses your non-desire to remove the
"unpacked refs" test in your earlier email
<20091025161630.GB8532@localhost>.)

In the "old" (v1.6.5) http push mechanism, no refspec is passed to the
http-push helper. This shouldn't be the case, because match_refs is
done in transport.c::transport_push, but then transport->push_refs
isn't defined so this doesn't happen.

http-push is then depended on to learn of the remote refs and match
them itself, but it does badly at this, since it only recurses through
/refs/heads in the remote repository. None could be found, since
they've all been packed. Thus the push in the first test failed.
Nothing has been pushed to the remote repository. The following push
in the "unpacked refs" corrects this after "unpacking" the refs.

Clearly, these test are about the ability of http push mechanism to
learn of refs in /refs/heads and (lack thereof) from /packed-refs.

But in this patch series, this is no longer the case.
transport->push_refs is now defined, so what happens is that the
http-push helper is passed a refspec, unlike in the "old" mechanism.
http-push, using this refspec, now matches refs properly (though it
still does its recursion thing). Thus the push in the first test
(should) succeed. The push in the "unpacked refs" test is now
irrelevant, since the first push has already successfully pushed
changes to the remote repository.

So, what we should have is just one no-frills push test, keeping as
well the "push already up-to-date" test.

-- 
Cheers,
Ray Chuan
