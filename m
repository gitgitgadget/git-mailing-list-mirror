Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335F423496F
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625029; cv=none; b=pY2u72Lzn36qdO/4pjo2QJwiivWeDTxPD0+ygZVjnjqZ+y/eDebGaiuHB3MyHjKyp/yhRc/iXW6ozdcdUOgUWyP0LYrwfCR7b9pdjXSHfpRhjee4qeX9btEBMfJtcuunkMjcj926cm/xgISEck1PYUtRm+O2svDWsy6rvzf6lGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625029; c=relaxed/simple;
	bh=YZJprEiy5sIYhuGYM+mAGqDijGvllmilLNzTah1lZho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEpJqoFBmczSMVOwW4m42kMOiVY0HkG9siEAjEruL1+pZINQZ5T0HDCkq4Jqa4URipy9tEAcMfE/ssApfxQZrug3HpDuM+p6eS2yFZap2j71fP8j9c1Lh2l1uRic8Je+mLULanSfrfXAimczfQ9b4mjUnzUy4HCgSgZNKpa7e1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=I0hsXNYB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="I0hsXNYB"
Received: (qmail 41440 invoked by uid 109); 20 Nov 2025 07:50:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YZJprEiy5sIYhuGYM+mAGqDijGvllmilLNzTah1lZho=; b=I0hsXNYBu+O9HsC1Cv2WCnw2TsuwDGiObgVsW9CdAWmH1thuL8JegGad1767Eruwhm1tVPXTjlSbF4Zh7qZRVtN+r6U62eEEUtPT+583Mg1jOzchzv1egOJ5S61dgf92UbLF6oNzIYt10wXBp6SVA9Te1SicAeuQfg5JvUPqt4m428vbCAeAxGGYVLN/r/FzaU2kIK0G8i6KxGl2Mvqw7HhKOH8OMDG2OBK0xrhQkjT8QscuJFdnp0Jj59zhyttBSy3j0C9Fy5mCsSNImKQkMq0H7LP92AiTUFlLbaLxdcKPm51xHmuhdmwbgzM2CU82AJet1NfjsaQ8dbICu1FIFA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Nov 2025 07:50:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 62061 invoked by uid 111); 20 Nov 2025 07:50:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Nov 2025 02:50:23 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 20 Nov 2025 02:50:19 -0500
From: Jeff King <peff@peff.net>
To: Han Jiang <jhcarl0814@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: `git config get --type=path` results in segmentation fault on
 value starting with `:(optional)`
Message-ID: <20251120075019.GA1283645@coredump.intra.peff.net>
References: <CANrWfmQUuGKWPc6JCzeCaa9t98ag_Lyk0G_Prtd8YmqP-TiRpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANrWfmQUuGKWPc6JCzeCaa9t98ag_Lyk0G_Prtd8YmqP-TiRpg@mail.gmail.com>

On Thu, Nov 20, 2025 at 07:46:42PM +1300, Han Jiang wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> git -c 'section.key-path=/nonexistent' config get --show-origin
> --show-scope --all --type=path 'section.key-path'
> git -c 'section.key-path=:(optional)/nonexistent' config get
> --show-origin --show-scope --all --type=path 'section.key-path'
> 
> What did you expect to happen? (Expected behavior)
> 
> 1st command outputs "command command line:   C:/Program Files/Git/nonexistent";
> 2nd command outputs nothing, $?=1;
> 
> What happened instead? (Actual behavior)
> 
> 1st command outputs "command command line:   C:/Program Files/Git/nonexistent";
> 2nd command outputs "Segmentation fault", $?=139;

The issue is that git_config_pathname(), when it sees the ":(optional)"
marker, may return success (0) to the caller without actually setting
the "dest" parameter. So if we are lucky, we get a NULL and segfault,
but we may get any random data from the uninitialized pointer. Here's
another caller which exhibits similar problems:

  $ git -c blame.ignorerevsfile=':(optional)foo' blame
  double free or corruption (out)
  Aborted                    git -c blame.ignorerevsfile=':(optional)foo' blame

This is all due to 749d6d166d (config: values of pathname type can be
prefixed with :(optional), 2025-09-28), which changed the contract for
git_config_pathname(). Before that patch, if the function returned 0,
then "dest" was guaranteed to point to a string. Now the caller must:

  - set the dest parameter to some known value like NULL before the call

  - after seeing success, check whether dest points to a string (if they
    want to know whether we actually got a path).

This more or less[*] does the right thing when the dest points to a
static global, and we call it from a config callback. In that case the
destination is initialized to NULL, and anybody who looks at the
variables assumes that NULL means "it was never set at all". And that's
the case for commit.template, which is what the test from 749d6d166d
covers.

But many other callers are broken. E.g., blame.ignorerevsfile does this:

          if (!strcmp(var, "blame.ignorerevsfile")) {
                  char *str;
                  int ret;
  
                  ret = git_config_pathname(&str, var, value);
                  if (ret)
                          return ret;
                  string_list_insert(&ignore_revs_file_list, str);
                  free(str);
                  return 0;
          }

which tries to insert (and then free!) uninitialized bytes from "str".
Likewise git-config does:

                  } else if (opts->type == TYPE_PATH) {
                          char *v;
                          if (git_config_pathname(&v, key_, value_) < 0)
                                  return -1;
                          strbuf_addstr(buf, v);
                          free((char *)v);
		  }[...]

Those (and some others) all need to be updated to the new semantics.
Something like this would fix the blame one:

diff --git a/builtin/blame.c b/builtin/blame.c
index 2703820258..15d719aec3 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -733,13 +733,14 @@ static int git_blame_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "blame.ignorerevsfile")) {
-		char *str;
+		char *str = NULL;
 		int ret;
 
 		ret = git_config_pathname(&str, var, value);
 		if (ret)
 			return ret;
-		string_list_insert(&ignore_revs_file_list, str);
+		if (str)
+			string_list_insert(&ignore_revs_file_list, str);
 		free(str);
 		return 0;
 	}

I am tempted to say that git_config_pathname() should set the dest to
NULL itself in this case, but it is really only half the battle (callers
still need to check for NULL before looking at the value).

I am not sure about the git-config one, though. What should it print for
an optional path that is not there? The empty string? Is it an error?

I put a [*] above on "more or less does the right thing" because there's
another corner case, even for callers like commit.template. What should
this:

  [commit]
  template = :(optional)does-exist
  template = :(optional)does-not-exist

With the current code, we will ignore the second config entry entirely,
and the result will point to "does-exist". But that feels surprising to
me. I'd expect the "optional" marker to set the value unconditionally,
but with an annotation that the entry does not need to exist. And that's
something only the caller can interpret (for commit.template, it means
setting it back to NULL, but for blame.ignorerevsfile, it means skipping
the string list insertion when it's not there).

I kind of wonder if git_config_pathname() ought to be returning more
data to the caller, like:

  struct config_pathname {
	char *path; /* never NULL */
	unsigned missing : 1;
  };

That would change the interface of git_config_pathname(), but that would
also force us to make the appropriate changes in each caller.

-Peff
