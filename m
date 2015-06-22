From: Junio C Hamano <gitster@pobox.com>
Subject: Re: apply --cached --whitespace=fix now failing on items added with "add -N"
Date: Mon, 22 Jun 2015 10:06:22 -0700
Message-ID: <xmqqa8vrisfl.fsf@gitster.dls.corp.google.com>
References: <CACfKtTAvH7FH2AkC5hUNFEQ620gF401SNYaULLy62iE8S55-7A@mail.gmail.com>
	<CACsJy8BBxWme=y6jF_O74Jz37qPy=Sqf4w0cg-QLYzpxM5iwVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Higgins <phiggins@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 19:06:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z75B1-0007k2-3D
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 19:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbbFVRG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 13:06:26 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:32879 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbFVRGY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 13:06:24 -0400
Received: by igbqq3 with SMTP id qq3so68238005igb.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aNUjv/3gX2e5Dl4pGaludCOzKyA7xYUav+Wm2BZsDuQ=;
        b=anHMc9vWKhpuS2gCYfQrriHLbABXqEffJojzN4okgVxpUPU3wRlvtN0WgEaj53ghgm
         /FPsq4i2TWaMj0OXkVCPrYR02MgLtglhFm9H9FcDByvD/z8eI8v2MlOxR/z2OeMO9d0y
         tBokzdHseq/oStIu7hSM2bNO6vRexiWzqMakDl2A/p6g8X2ydnRjkD4kL7LZ2Ss4UpN4
         Qyh3mrWUyFyjvHcUfWXznm1LKlJDDO1pVlx18b7CigxPL+LGBIHr0qDL8/xmvuLzV2Y8
         wZoj8j32U6v13hxyRVWCCMNZaqyBWlS7Y9+8sMTHQ7X5voHIFT8DsGsoKibXoQD6ItfA
         Uqvg==
X-Received: by 10.107.165.210 with SMTP id o201mr41127507ioe.2.1434992784010;
        Mon, 22 Jun 2015 10:06:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id h7sm7875086igt.3.2015.06.22.10.06.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 10:06:23 -0700 (PDT)
In-Reply-To: <CACsJy8BBxWme=y6jF_O74Jz37qPy=Sqf4w0cg-QLYzpxM5iwVw@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 22 Jun 2015 21:45:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272398>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jun 22, 2015 at 9:29 PM, Patrick Higgins <phiggins@google.com> wrote:
>> I like to use git to remove trailing whitespace from my files. I use
>> the following ~/.gitconfig to make this convenient:
>>
>> [alias]
>>         wsadd = "!sh -c 'git diff -- \"$@\" | git apply --cached
>> --whitespace=fix;\
>>                 git checkout -- ${1-.} \"$@\"' -"
>>
>> The wsadd alias doesn't work with new files, so I have to use "git add
>> -N" on them first. As of a week or two ago, the "apply --cached" step
>> now fails with the following, assuming a new file named bar containing
>> "foo " has been added with "add -N":
>>
>> $ git diff -- "$@" | git apply --cached --whitespace=fix
>> <stdin>:7: trailing whitespace.
>> foo
>> error: bar: already exists in index
>>
>> The final "git checkout" at the end of wsadd truncates my file. I've
>> changed the ";" to a "&&" to fix the truncation.
>>
>> Were there any recent changes to "git apply" that might have caused this?
>
> Probably fallout from this one, merged to 'master' about 5 weeks ago.
> I'll have a look at it tomorrow unless somebody does it first
>
> d95d728 (diff-lib.c: adjust position of i-t-a entries in diff - 2015-03-16)

Yeah, the world order has changed by that commit, and I would expect
to see some more fallouts.

After "add -N", "git diff" used to pretend that an empty blob was in
the index, and showed a modification between an existing "empty" and
the full file contents, and "git apply --cached" was happy to take
that modification.  In the new world order, "git diff" is instructed
to pretend as if the path that was added by "add -N" does not exist
yet in the index at all, but the index still knows about the path,
which is a strange half-born state.  It shows an addition of the
full file contents as a new file.  "git apply --cached" sees an
addition of a new path, which requires that the path does not exist
in the index.  In the new world order, it should be taught to
pretend that these "add -N" paths do not exist in the index, but
that was not done.

Something like the attached (totally untested) may be a good
starting point.

For another potential fallout, try this:

    $ cp COPYING RENAMING
    $ cp COPYING UNTRACKED
    $ >EMPTY
    $ git add -N RENAMING EMPTY
    $ git rm UNTRACKED
    fatal: pathspec 'UNTRACKED' did not match any files
    $ git rm EMPTY RENAMING
    error: the following file has staged content different from both the
    file and the HEAD:
        EMPTY
        RENAMING
    (use -f to force removal)

One could argue that these three should behave the same way, if the
new world order is "path added by 'add -N' does not exist in the
index".

I however think the new world order should be slightly different
from "does not exist in the index", but should be more like "the
index is aware of its presence but has not been told about its
contents yet".  The consequences of this are:

 - "git rm RENAMING" shouldn't say 'did not match any files'.

 - "git rm RENAMING" does not know about 'staged content', so
   complaining about "staged contents different from file and HEAD"
   feels wrong.

Having said that, I do think erroring out and requiring -f is the
right thing when remiving RENAMING and EMPTY.  Unlike contents added
by "git add" without "-N", we do not know what is in the working
tree file at all.  Given that we check and refuse when the contents
are different between the working tree file, the index and the HEAD
even when we know what was in the working tree when "git add"
without "-N" was done, we should keep the safety to prevent
accidental removal of the working tree file, which has the only
existing copy of the user content.

On the other hand, I am also OK if the behaviour was like this:

    $ git rm --cached RENAMING
    ... removed without complaints ...
    $ git rm RENAMING
    error: file 'RENAMING' does not have staged content yet.
    (use -f to force removal)

In any case, here is a "how about this" weather-balloon patch for
"git apply"

 builtin/apply.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 146be97..653191e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3546,12 +3546,23 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 #define EXISTS_IN_INDEX 1
 #define EXISTS_IN_WORKTREE 2
 
+static int exists_in_index(const char *new_name)
+{
+	int pos = cache_name_pos(new_name, strlen(new_name));
+
+	if (pos < 0)
+		return 0;
+	if (active_cache[pos]->ce_flags & CE_INTENT_TO_ADD)
+		return 0;
+	return 1;
+}
+
 static int check_to_create(const char *new_name, int ok_if_exists)
 {
 	struct stat nst;
 
 	if (check_index &&
-	    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
+	    exists_in_index(new_name) &&
 	    !ok_if_exists)
 		return EXISTS_IN_INDEX;
 	if (cached)
