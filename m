From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] status: report ignored yet tracked directories
Date: Sun, 6 Jan 2013 17:40:46 +0100
Message-ID: <CALWbr2yRQai2Z08G2qFbA3AvsgivR-8kQ64SZ4pEktyrf+ZXiQ@mail.gmail.com>
References: <20130105112432.GA14666@sigill.intra.peff.net>
	<1357418563-6626-1-git-send-email-apelisse@gmail.com>
	<20130105230303.GA5195@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 06 17:41:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrtHX-0005ci-JN
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 17:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064Ab3AFQkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 11:40:49 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36623 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756050Ab3AFQkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 11:40:47 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so9130406eek.33
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8l5se3YQ4lxNWW9POHFO2LBM9PM90tWZTa1U9IcQYAs=;
        b=NoxhkvBHUNxur1s/FoQZlQVl60XxLtFKNMh3GBD3ia5poGF/G+1DIp1hUbVc54w7kr
         /D6NHnrI/geDPugs1GFdPNzD8pIndPCfoPl2xLF0i5FvUD0R+OaG5gJgMdGzkmSCSg3+
         gEj5fFALKy1SBEwa4ky0hFbWAXPcesgo0Kjof9gdXgRQr3Ife5s3vNVzFgmFeCAjG8F7
         B507lAP6q+AbcdUlf+qKPEDV335ox+CVcLxWUZmS9fAypyuNrgCh0ZNn+zPjA70sD6WQ
         hIEI4BnnqRqpWGXH0NjeNs1Dyiz8SjULDsBMDHlsWoUUcx2uoP2tjBM4ZNEDKJ9ypgz8
         KiBw==
Received: by 10.14.1.195 with SMTP id 43mr160895653eed.31.1357490446501; Sun,
 06 Jan 2013 08:40:46 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Sun, 6 Jan 2013 08:40:46 -0800 (PST)
In-Reply-To: <20130105230303.GA5195@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212813>

On Sun, Jan 6, 2013 at 12:03 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Jan 05, 2013 at 09:42:43PM +0100, Antoine Pelisse wrote:
>
>> Tracked directories (i.e. directories containing tracked files) that
>> are ignored must be reported as ignored if they contain untracked files.
>>
>> Currently, tracked files or directories can't be reported untracked or ignored.
>> Remove that constraint when searching ignored files.
>>
>> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
>> ---
>
> I was expecting to see some explanation of the user-visible bug here. In
> other words, what does this fix, and why does the bug only happen when
> core.ignorecase is set.

I spent a couple of hours trying to understand that issue, and even if
I ended-up with pretty much the same points as you do below, I was not
confident enough to phrase it like you just did.

> Looking at your fix and remembering how the index hashing works, I think
> the answer is that:
>
>   1. This bug only affects directories, because they are the only thing
>      that can be simultaneously "ignored and untracked" and "tracked"
>      (i.e., they have entries of both, and we are using
>      DIR_SHOW_OTHER_DIRECTORIES).
>
>   2. When core.ignorecase is false, the index name hash contains only
>      the file entries, and cache_name_exists returns an exact match. So
>      it doesn't matter if we make an extra check when adding the
>      directory via dir_add_name; we know that it will not be there, and
>      the final check is a no-op.
>
>   3. When core.ignorecase is true, we also store directory entries in
>      the index name hash, and this extra check is harmful; the entry
>      does not really exist in the index, and we still need to add it.

Yes, because of this couple of lines I guess (name-hash.c, hash_index_entry()):

  if (ignore_case)
    hash_index_entry_directories(istate, ce);

> But that makes me wonder. In the ignorecase=false case, I claimed that
> the check in dir_add_name is a no-op for mixed tracked/ignored
> directories. But it is presumably not a no-op for other cases. Your
> patch only turns it off when DIR_SHOW_IGNORED is set. But is it possible
> for us to have DIR_SHOW_IGNORED set, _and_ to pass in a path that exists
> in the index as a regular file?

I don't think so, because of the optimization I added in my previous
patch, in treat_file():

  /*
   * Optimization:
   * Don't spend time on indexed files, they won't be
   * added to the list anyway
   */
  struct cache_entry *ce = index_name_exists(&the_index,
    path->buf, path->len, ignore_case);

It's no longer an optimization but a required step, I will update the comment.

> I think in the normal file case, we'd expect treat_path to just tell us
> that it is handled, and we would not ever call dir_add_name in the first
> place. But what if we have an index entry for a file, but the working
> tree now contains a directory?

The directory is treated as any other untracked directory (it never
matches indexed file because of the trailing /).

> I _think_ we still do not hit this code path in that instance, because
> we will end up in treat_directory, and we will end up checking
> directory_exists_in_index. And I cannot get it to misbehave in practice.
> So I think your fix is correct, but the exact how and why is a bit
> subtle.

Thanks a lot for the help, I will try to come up with a better commit
message now.

> -Peff
