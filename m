Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609918BBAC
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084047; cv=none; b=Q4FO2vjKh+XIlJBINQTQzfpT3RmIztKy2F9hijYljXl2BqPAvMNnk0PMaDrgsaL8JrgITjuOfiQL3WYtOIuCKqL1SxswNp4Jo4wdfGUUfiFR6jSzEHBrxTitXopLV/cvUYxMf7nd1XfjWsvhWjS0FdT5vk50oJlMXIukWPvou9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084047; c=relaxed/simple;
	bh=YJZUoiT9vCc87PhDXSR1CeFLBNmSPNjJ5z9kdibsrS0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UPdz8kpvixwgfxVE9fvOfIPN+ozSUa5mqXyWqzOte5axxtsS3oMBDNXviLfmUwvmju2NkfRsX5/gLZBvZT/7Q5Bm7Gp0cIdZ/DAcuq8gxdiq5FkuH2RdHJKwbxydSGstMbI+U/MHj+ifWno8En5e4kAcxD7xA17W3wWVmfOjg+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=aZU+wsBe; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="aZU+wsBe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734084041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MPm+iP5OVcI8QTBbkjOP3Z4MUiJg1LrlO29vOp1LDZM=;
	b=aZU+wsBeBP8+7TWrBoSy7P22A/RSeqf73b0XyMCFv3gX3b1QRIUkLUTrZyAL1l/GylA0tr
	uouWWB4SWt6ojMjG/gOxIhw+R1GWmxaFSr84KjUgUM2NL1lurrcGm7u/2pb01ajPUK4z2s
	r2CuhJGhtwZfDvKm03yWL3EVUkc3Q8g=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 6/8] t: fix out-of-tree tests for some git-p4 tests
In-Reply-To: <20241211-pks-meson-ci-v1-6-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
 <20241211-pks-meson-ci-v1-6-28d18b494374@pks.im>
Date: Fri, 13 Dec 2024 11:00:23 +0100
Message-ID: <87a5czj420.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Both t9835 and t9836 exercise git-p4, but one exercises Python 2 whereas
> the other one uses Python 3. These tests do not exercise "git p4", but
> instead they use "git p4.py" so that the unbuilt version of "git-p4.py"
> is used that has "#!/usr/bin/env python" as shebang instead of the
> replaced shebang.

It took me a while to figure out what you mean by "the replaced
shebang"? I think you mean something like:

    These tests do not exercise "git p4", but instead they use "git
    p4.py". This calls the unbuilt version of "git-p4.py", which has the
    "#!/usr/bin/env python" shebang. This allows the test to modify
    which `python` comes first in $PATH, making it possible to force a
    Python version.

> But "git-p4.py" is not in our PATH during out-of-tree builds, and thus
> we cannot locate "git-p4.py". The tests thus break with CMake and Meson.
>
> Fix this by instead manually setting up script wrappers that invoke the
> respective Python interpreter directly.

I like this approach, way more explicit now the Python version is in the
command itself.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t9835-git-p4-metadata-encoding-python2.sh | 48 ++++++++++++++-------------
>  t/t9836-git-p4-metadata-encoding-python3.sh | 50 ++++++++++++++---------------
>  2 files changed, 50 insertions(+), 48 deletions(-)
>
> diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4-metadata-encoding-python2.sh
> index 036bf79c6674f6f1f0d667c7270674168428ffee..02f9ec09053890a4d41b7dc95644066d6481bbb6 100755
> --- a/t/t9835-git-p4-metadata-encoding-python2.sh
> +++ b/t/t9835-git-p4-metadata-encoding-python2.sh
> @@ -14,23 +14,25 @@ python_target_version='2'
>  ## SECTION REPEATED IN t9836 ##

To be honest, I don't understand why this section wasn't put in a
function in lib-git-p4.sh in the first place, instead of duplicating?
Anyhow, I think for two test files it's fine to duplicate this code, and
after all you're not changing that.

But I've noticed you are no longer using `python_target_version`. I
would suggest to either remove the variable, or use it again so the code
between the two test files is identical again. Doing the latter would
probably mean you also need to create a variable like
`p4_python=p4-python$python_target_version` and use `$p4_python` instead
of `p4-python2` throughout the script, so I'm not sure that improves
things.

>  ###############################
>  
> -# Please note: this test calls "git-p4.py" rather than "git-p4", because the
> -# latter references a specific path so we can't easily force it to run under
> -# the python version we need to.
> -
> -python_major_version=$(python -V 2>&1 | cut -c  8)
> -python_target_binary=$(which python$python_target_version)
> -if ! test "$python_major_version" = "$python_target_version" && test "$python_target_binary"
> +# These tests are specific to Python 2. Write a custom script that executes
> +# git-p4 directly with the Python 2 interpreter to ensure that we use that
> +# version even if Git was compiled with Python 3.
> +python_target_binary=$(which python2)
> +if test -n "$python_target_binary"
>  then
>  	mkdir temp_python
> -	PATH="$(pwd)/temp_python:$PATH" && export PATH
> -	ln -s $python_target_binary temp_python/python
> +	PATH="$(pwd)/temp_python:$PATH"
> +	export PATH
> +
> +	write_script temp_python/git-p4-python2 <<-EOF
> +	exec "$python_target_binary" "$(git --exec-path)/git-p4" "\$@"
> +	EOF
>  fi
>  
> -python_major_version=$(python -V 2>&1 | cut -c  8)
> -if ! test "$python_major_version" = "$python_target_version"
> +git p4-python2 >err
> +if ! grep 'valid commands' err

I like this sanity check, this verifies if the command actually works:

Thus the output when the script is properly created:

    usage: /home/toon/devel/git/git-p4 <command> [options]

    valid commands: branches, clone, sync, submit, unshelve, commit, rebase

    Try /home/toon/devel/git/git-p4 <command> --help for command specific help.


And when the script was not written:

    git: 'p4-python2' is not a git command. See 'git --help'.


I noticed though, the stderr output isn's shallowed into /dev/null,
resulting the output for the test to be the following if Python 2 is not found:

    make[2]: Entering directory '/home/toon/devel/git/t'
    *** t9835-git-p4-metadata-encoding-python2.sh ***
    which: no python2 in (/home/toon/devel/git/bin-wrappers:/home/toon/.local/bin:[snip])
    git: 'p4-python2' is not a git command. See 'git --help'.
    not ok 1 - start p4d


I think that's totally fine though, it's giving the user proper
information about what is wrong.

--
Toon
