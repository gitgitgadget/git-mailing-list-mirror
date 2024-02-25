Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4D1367
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708888126; cv=none; b=efCibF+P+Ktqfn6yw5U0pmKfoKNsSH+rmqGrzyYaSgkS15zFJYXNwYaIxhk6309pPJ7lbNRCslLHryP+YebPApzw9Ig1TNw1VgbmtpRdFVPmwLit8gR4WzgtiQ5ktupdLNS+r//flJU3jSdnFdbNvx1RYHdmieODPo+6vhi4ca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708888126; c=relaxed/simple;
	bh=MaPB9PsMkjcarQozf4urgxMJ52TTsQpp+OR9NeVGywU=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=TfLGS7c0XSEbepkc/Vqr/gEyXZiK8gFdq39b/kDUAn4SIGmW2+BLSR/CYTvDciWBVpniAh68zm4zdzyHQyCbv5bmnR0IHQaLhf5qfTq/3yN0HRzk4XEKIOKWR0tTakSabRfASKx6hYPKBRKsd1X5eI0q+KBwVnOxG9SsnjiQYjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41PJ8eRC2002020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 19:08:41 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <rsbecker@nexbridge.com>, <git@vger.kernel.org>
References: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com>
In-Reply-To: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com>
Subject: RE: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
Date: Sun, 25 Feb 2024 14:08:35 -0500
Organization: Nexbridge Inc.
Message-ID: <01be01da681e$0c349090$249db1b0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQH6KeHXK3ktIx6cNmAt1sL267+NobDb58ww

On Sunday, February 25, 2024 1:45 PM, I wrote:
>To: git@vger.kernel.org
>Subject: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
>
>This appears to be a new issue introduced at 2.44.0. It only occurs on
NonStop ia64
>but not on x86. I am not sure why this is happening although 1Mb exceeds
the
>single I/O size on this machine.
>
>expecting success of 7704.9 '--max-cruft-size with pruning':
>        git init max-cruft-size-prune &&
>        (
>                cd max-cruft-size-prune &&
>
>                test_commit base &&
>                foo="$(generate_random_blob foo $((1024*1024)))" &&
>                bar="$(generate_random_blob bar $((1024*1024)))" &&
>                baz="$(generate_random_blob baz $((1024*1024)))" &&
>
>                test-tool chmtime -10000 "$objdir/$(test_oid_to_path
"$foo")" &&
>
>                git repack -d --cruft --max-cruft-size=1M &&
>
>                # backdate the mtimes of all cruft packs to validate
>                # that they were rewritten as a result of pruning
>                ls $packdir/pack-*.mtimes | sort >cruft.before &&
>                for cruft in $(cat cruft.before)
>                do
>                        mtime="$(test-tool chmtime --get -10000 "$cruft")"
>&&
>                        echo $cruft $mtime >>mtimes || return 1
>                done &&
>
>                # repack (and prune) with a --max-cruft-size to ensure
>                # that we appropriately split the resulting set of packs
>                git repack -d --cruft --max-cruft-size=1M \
>                        --cruft-expiration=10.seconds.ago &&
>                ls $packdir/pack-*.mtimes | sort >cruft.after &&
>
>                for cruft in $(cat cruft.after)
>                do
>                        old_mtime="$(grep $cruft mtimes | cut -d" " -f2)"
&&
>                        new_mtime="$(test-tool chmtime --get $cruft)" &&
>                        test $old_mtime -lt $new_mtime || return 1
>                done &&
>
>                test_line_count = 3 cruft.before &&
>                test_line_count = 2 cruft.after &&
>                test_must_fail git cat-file -e $foo &&
>                git cat-file -e $bar &&
>                git cat-file -e $baz
>        )
>
>Initialized empty Git repository in
>/home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/t/trash
>directory.t7704-repack-cruft/max-cruft-size-prune/.git/
>[master (root-commit) d1ff1c9] base
> Author: A U Thor mailto:author@example.com
> 1 file changed, 1 insertion(+)
> create mode 100644 base.t
>Enumerating objects: 3, done.
>Counting objects: 100% (3/3), done.
>Writing objects: 100% (3/3), done.
>Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0) Enumerating
cruft
>objects: 6, done.
>Counting objects: 100% (3/3), done.
>Compressing objects: 100% (3/3), done.
>Writing objects: 100% (3/3), done.
>Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0) Enumerating
objects: 3,
>done.
>Counting objects: 100% (3/3), done.
>Writing objects: 100% (3/3), done.
>Total 3 (delta 0), reused 3 (delta 0), pack-reused 0 (from 0)
>ls: cannot access '.git/objects/pack/pack-*.mtimes': No such file or
directory
>test_line_count: line count for cruft.after != 2 not ok 9 -
--max-cruft-size with
>pruning #
>#               git init max-cruft-size-prune &&
>#               (
>#                       cd max-cruft-size-prune &&
>#
>#                       test_commit base &&
>#                       foo="$(generate_random_blob foo $((1024*1024)))" &&
>#                       bar="$(generate_random_blob bar $((1024*1024)))" &&
>#                       baz="$(generate_random_blob baz $((1024*1024)))" &&
>#
>#                       test-tool chmtime -10000
"$objdir/$(test_oid_to_path
>"$foo")" &&
>#
>#                       git repack -d --cruft --max-cruft-size=1M &&
>#
>#                       # backdate the mtimes of all cruft packs to
validate
>#                       # that they were rewritten as a result of pruning
>#                       ls $packdir/pack-*.mtimes | sort >cruft.before &&
>#                       for cruft in $(cat cruft.before)
>#                       do
>#                               mtime="$(test-tool chmtime --get -10000
>"$cruft")" &&
>#                               echo $cruft $mtime >>mtimes || return 1
>#                       done &&
>#
>#                       # repack (and prune) with a --max-cruft-size to
>ensure
>#                       # that we appropriately split the resulting set of
>packs
>#                       git repack -d --cruft --max-cruft-size=1M \
>#                               --cruft-expiration=10.seconds.ago &&
>#                       ls $packdir/pack-*.mtimes | sort >cruft.after &&
>#
>#                       for cruft in $(cat cruft.after)
>#                       do
>#                               old_mtime="$(grep $cruft mtimes | cut -d" "
>-f2)" &&
>#                               new_mtime="$(test-tool chmtime --get
>$cruft)" &&
>#                               test $old_mtime -lt $new_mtime || return 1
>#                       done &&
>#
>#                       test_line_count = 3 cruft.before &&
>#                       test_line_count = 2 cruft.after &&
>#                       test_must_fail git cat-file -e $foo &&
>#                       git cat-file -e $bar &&
>#                       git cat-file -e $baz
>#               )
>#
>1..9

I did find the following calls to write(), one of which might be involved.
write() should not be used directly unless the count is clearly very small.
Xwrite() should be used instead. There are other calls but those are either
small or not on platform.

reftable/writer.c:              int n = w->write(w->write_arg, zeroed,
w->pending_padding);
reftable/writer.c:      n = w->write(w->write_arg, data, len);
run-command.c:                  len = write(io->fd, io->u.out.buf,
t/helper/test-path-utils.c:                     if (write(1, buffer, count)
< 0)
t/helper/test-windows-named-pipe.c:             write(1, buf, nbr);
t/helper/test-windows-named-pipe.c:             write(1, buf, nbr);
trace2/tr2_dst.c:       bytes = write(fd, buf_line->buf, buf_line->len);



