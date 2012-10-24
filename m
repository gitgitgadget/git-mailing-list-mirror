From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Wed, 24 Oct 2012 19:52:28 +0200
Message-ID: <CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
	<1320535407-4933-2-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 19:53:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR58V-0006s1-E6
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 19:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935341Ab2JXRwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 13:52:31 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:34697 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935092Ab2JXRw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 13:52:29 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so716905oag.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YFpha58jQC9144twEH9TYr6J3ldaEqlTaZ+DOvn9f54=;
        b=vUtlqFZU1ofjZ/MfpGPIugfnKpFQD7G2m3MN9Vqw3XafpJXx4igTM3nBIcbXapaGHx
         LnflDu0c6AEz/N0exXwDXtW9uAde/ZH+mV767B0bVdnzUS+auRiKDsXDPACjcfRFfq4B
         QzAjFWrZMpOuw6c2VkgFzgoMQYpWV7JJvuHsjdOYscZYV5GqmNZJIHeFLDD5wYZmswnA
         qNwcuosA/7aFlVeQP+gSkAAFRdyh2jBTc5a0scp5IJP+4JrDKrQzIUgshktMxhIQtqEW
         mZFI5DoMGJ28uE0+1OBth5shMnKzO7uxX1oh9dKu7VWoQ5UYKL1JLOgk/GEdp7lRoBiD
         pSMg==
Received: by 10.182.245.20 with SMTP id xk20mr13521899obc.89.1351101148781;
 Wed, 24 Oct 2012 10:52:28 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 24 Oct 2012 10:52:28 -0700 (PDT)
In-Reply-To: <1320535407-4933-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208312>

Hi,

Joined late to the party :)

On Sun, Nov 6, 2011 at 12:23 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> This happens only when the corresponding commits are not exported in
> the current fast-export run. This can happen either when the relevant
> commit is already marked, or when the commit is explicitly marked
> as UNINTERESTING with a negative ref by another argument.
>
> This breaks fast-export based remote helpers, as they use marks
> files to store which commits have already been seen. The call graph
> is something as follows:
>
> $ # push master to remote repo
> $ git fast-export --{im,ex}port-marks=marksfile master
> $ # make a commit on master and push it to remote
> $ git fast-export --{im,ex}port-marks=marksfile master
> $ # run `git branch foo` and push it to remote
> $ git fast-export --{im,ex}port-marks=marksfile foo

That is correctly, but try this:
$ git fast-export --{im,ex}port-marks=marksfile foo foo

Now foo is updated.

> When fast-export imports the marksfile and sees that all commits in
> foo are marked as UNINTERESTING (they have already been exported
> while pushing master), it exits without doing anything. However,
> what we want is for it to reset 'foo' to the already-exported commit.
>
> Either way demonstrates the problem, and since this is the most
> succint way to demonstrate the problem it is implemented by passing
> master..master on the commandline.
>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
>  t/t9350-fast-export.sh |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 950d0ff..74914dc 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -440,4 +440,15 @@ test_expect_success 'fast-export quotes pathnames' '
>         )
>  '
>
> +cat > expected << EOF
> +reset refs/heads/master
> +from $(git rev-parse master)
> +
> +EOF
> +
> +test_expect_failure 'refs are updated even if no commits need to be exported' '
> +       git fast-export master..master > actual &&
> +       test_cmp expected actual
> +'
> +
>  test_done

This test is completely wrong.

1) Where are the marks file?
2) master..master shouldn't export anything
3) Why do you expect a SHA-1? It could be a mark.

I decided to write my own this way:

---
cat > expected << EOF
reset refs/heads/master
from ##mark##

EOF

test_expect_failure 'refs are updated even if no commits need to be exported' '
	cp tmp-marks /tmp
	git fast-export --import-marks=tmp-marks \
		--export-marks=tmp-marks master | true &&
	git fast-export --import-marks=tmp-marks \
		--export-marks=tmp-marks master > actual &&
	mark=$(grep $(git rev-parse master) tmp-marks | cut -f 1 -d " ")
	sed -i -e "s/##mark##/$mark/" expected &&
	test_cmp expected actual
'
---

Yes, it's true this fails, but change to 'master master', and then it works.

This can be easily fixed by this patch:

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 12220ad..3b4c2d6 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -523,10 +523,13 @@ static void get_tags_and_duplicates(struct
object_array *pending,
                                typename(e->item->type));
                        continue;
                }
-               if (commit->util)
-                       /* more than one name for the same object */
+               /*
+                * This ref will not be updated through a commit, lets make
+                * sure it gets properly updated eventually.
+                */
+               if (commit->util || commit->object.flags & SHOWN)
                        string_list_append(extra_refs,
full_name)->util = commit;
-               else
+               if (!commit->util)
                        commit->util = full_name;
        }
 }

Now if you specify a ref it will get updated regardless. However, this
points to another bug:

% git fast-export --{im,ex}port-marks=/tmp/marks master ^foo foo.foo

The foo ref will be reset _twice_ because all pending refs after the
first one get reset no matter how they were specified.

That is already the case, my patch will cause this to generate the same output:

% git fast-export --{im,ex}port-marks=/tmp/marks ^foo foo.foo

Which is still not got, but not catastrophic by any means.

Cheers.

-- 
Felipe Contreras
