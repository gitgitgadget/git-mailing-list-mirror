Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489217995
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022171; cv=none; b=Q4q1AdwfXUWDnTXNJqcGWL9t/jdWfvCDDYPb89T+3fKtgZ6TYbSAun9MItnxvCFcV4DeJixnOh33wQVLNmrwbRhYjixouLxyKuaULg8tBtTonsIhzGn3Ig9A/5kVvFjIT7JBxwlKon2HaVKyqxWZeP5NOwyhNDoxFY9Sc50RIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022171; c=relaxed/simple;
	bh=V9MqMPpU4e9TiAAV3f0bReISut/YDxQPuP9izqJvpiE=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SeOaVbvIKr1EPterQhDlvKLUDah8y3beRs71H7/1hiHiBVtzqAB+0VAgbJZ/i/jj8LAG9BMgUcU5bUDRaWSV30dxwtyGptxmISHLyUFLgYqpx56yGv9OiE+QtHnu728AgQtLuo7obmNChZNZ/HnaLdRRRxBSyAW3N0usozieB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 463Fu2vt2220032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 15:56:02 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Emanuel Czirai'" <correabuscar+gitML@gmail.com>, <git@vger.kernel.org>
References: <CAFjaU5sAVaNHZ0amPXJcbSvsnaijo+3X5Otg_Mntkx2GbikZMA@mail.gmail.com>
In-Reply-To: <CAFjaU5sAVaNHZ0amPXJcbSvsnaijo+3X5Otg_Mntkx2GbikZMA@mail.gmail.com>
Subject: RE: `git diff`/`git apply` can generate/apply ambiguous hunks (ie. in the wrong place) (just like gnu diff/patch)
Date: Wed, 3 Jul 2024 11:55:56 -0400
Organization: Nexbridge Inc.
Message-ID: <082b01dacd61$81174a80$8345df80$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKXaDRlzTlnc5qW8ZsbGyRxQRdvZ7Br8jxQ
Content-Language: en-ca

On Wednesday, July 3, 2024 11:25 AM, Emanuel Czirai wrote:
>This doesn't affect `git rebase` as it's way more robust than simply =
extracting the
>commits as patches and re-applying them. (I haven't looked into `git =
merge` though,
>but I doubt it's affected)
>
>It seems to me that no matter which algorithm `git diff` uses  (of the =
4), it generates
>the same hunk, because it's really the context length that matters =
(which by default
>is 3), which is the same one that gnu `diff` generates, and its =
application via `git
>apply` is the same as gnu `patch`.
>
>side note:
>`diffy` is a simple rust-written library that behaves (at version =
0.4.0) the same as
>normal diff and patch apply(with regards to generated diff contents and =
patch
>application; except it doesn't set the original/modified filenames in =
the patch), and
>since my limited experience, I've found it simpler to modify it to make =
it so that it
>generates unambiguous hunks, as a proof of concept that it can be done =
this way,
>here:
>https://github.com/bmwill/diffy/issues/31 , whereby increasing the =
context
>length(lines) of the whole patch(though ideally only of the affected =
hunks) the
>initially ambiguous hunk(s) cannot be applied anymore in more than 1 =
place inside
>the original file, thus avoiding both the diff creation and the patch =
application from
>generating and applying ambiguous hunks.
>
>But forgetting about that for a moment, I'm gonna show you about `git =
diff` and `git
>apply` below:
>1. clone cargo's repo:
>cd /tmp
>git clone https://github.com/rust-lang/cargo.git
>cd cargo
>2. checkout tag 0.76.0, or branch origin/rust-1.75.0 git checkout =
0.76.0 3. manually
>edit this file ./src/cargo/core/workspace.rs at line 1118 or manually =
go to function:
>pub fn emit_warnings(&self) -> CargoResult<()> { right before that =
function's end
>which looks like:
>Ok(())
>}
>so there at line 1118, insert above that Ok(()) something, doesn't =
matter what,
>doesn't have to make sense, like:
>if seen_any_warnings {
>  //comment
>  bail!("reasons");
>}
>save the file
>4. try to generate a diff from it:
>git diff > /tmp/foo.patch
>you get this:
>```diff
>diff --git a/src/cargo/core/workspace.rs b/src/cargo/core/workspace.rs =
index
>4667c8029..8f0a74473 100644
>--- a/src/cargo/core/workspace.rs
>+++ b/src/cargo/core/workspace.rs
>@@ -1115,6 +1115,10 @@ impl<'cfg> Workspace<'cfg> {
>                 }
>             }
>         }
>+        if seen_any_warnings {
>+            //comment
>+            bail!("reasons");
>+        }
>         Ok(())
>     }
>
>```
>Now this is an ambiguous patch/hunk because if you try to apply this =
patch on the
>same original file, cumulatively, it applies successfully in 3 =
different places, but we
>won't do that now.
>5. now let's discard it(we already have it saved in /tmp/foo.patch) and =
pretend that
>something changed in the original code:
>git checkout .
>git checkout 0.80.0
>6. reapply that patch on the new changes:
>git apply /tmp/foo.patch
>(this shows no errors)
>7. look at the diff, for no good reason, just to see that it's the =
same(kind of):
>git diff > /tmp/foo2.patch
>contents:
>```diff
>diff --git a/src/cargo/core/workspace.rs b/src/cargo/core/workspace.rs =
index
>55bfb7a10..92709f224 100644
>--- a/src/cargo/core/workspace.rs
>+++ b/src/cargo/core/workspace.rs
>@@ -1099,6 +1099,10 @@ impl<'gctx> Workspace<'gctx> {
>                 }
>             }
>         }
>+        if seen_any_warnings {
>+            //comment
>+            bail!("reasons");
>+        }
>         Ok(())
>     }
>
>```
>8. now look at the file, where was the patch applied? that's right, =
it's at the end of
>the wrong function:
>fn validate_manifest(&mut self) -> CargoResult<()> { vim
>src/cargo/core/workspace.rs +1040 jump at the end of it at line 1107, =
you see it's
>our patch there, applied in the wrong spot!
>
>Hopefully, depending on the change, this kind of patch which applied in =
the wrong
>place, will be caught at (rust)compile time (in my case, it was this) =
or worse, at
>(binary)runtime.
>
>With the aforementioned `diffy` patch, the generated diff would =
actually be with a
>context of 4, to make it unambiguous, so it would've been this:
>```diff
>--- original
>+++ modified
>@@ -1186,8 +1186,12 @@
>                     self.gctx.shell().warn(msg)?
>                 }
>             }
>         }
>+        if seen_any_warnings {
>+            //use anyhow::bail;
>+            bail!("Compilation failed due to cargo warnings! Manually
>+ done
>this(via cargo patch) so that things like the following (ie. dep key =
packages=3D and
>using rust pre 1.26.0 which ignores it, downloads squatted
>package) will be avoided in the future:
>https://github.com/rust-lang/rust/security/advisories/GHSA-phjm-8x66-qw4=
r");
>+        }
>         Ok(())
>     }
>
>     pub fn emit_lints(&self, pkg: &Package, path: &Path) -> =
CargoResult<()> { ``` this
>hunk is now unambiguous because it cannot be applied in more than 1 =
place in the
>original file, furthermore patching a modified future file will =
fail(with that `diffy`
>patch, and ideally, with `git apply` if any changes are implemented to =
"fix" this issue)
>if any of the hunks can be independently(and during the full patch =
application too)
>applied in more than 1 place.
>
>I consider that I don't know enough to understand how `git diff`/`git =
apply` works
>internally (and similarly, gnu `diff`/`patch`) to actually change them =
and make them
>generate unambiguous hunks where only the hunks that would've been =
ambiguous
>have increased context size, instead of the whole patch have increased =
context size
>for all hunks(which is what I did for `diffy` too so far, in that proof =
of concept patch),
>therefore if a "fix" is deemed necessary(it may not be, as I might've =
missed
>something and I'm unaware of it, so a fix may be messing other things =
up, who
>knows?!) then I hope someone much more knowledgeable could implement
>it(maybe even for gnu diff/patch too), and while I don't think that a =
"please" would
>be enough, I'm still gonna say it: please do so, if so inclined.
>
>Thank you for your time and consideration.

You make good points, but Rust code should not be put into the main git =
code base as it will break many non-GNU platforms. Perhaps rewriting it =
is C to be compatible with the git code-base.
--Randall

