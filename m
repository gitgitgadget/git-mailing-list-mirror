From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Existing utility to track compiled files in another sister
 repository, for rollouts
Date: Thu, 23 Aug 2012 22:45:26 +0200
Message-ID: <CACBZZX4RoPDODMgbz1T+wEMT5K4X157G5VYtXFp=e+j0C0hqiQ@mail.gmail.com>
References: <CACBZZX6SVSn17nfSarQC1qgz-TxcDDn5tvHb0BkyW9S8DcLY4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 22:45:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4eHr-00006d-Cd
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 22:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933727Ab2HWUpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Aug 2012 16:45:50 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43143 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076Ab2HWUpr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 16:45:47 -0400
Received: by obbuo13 with SMTP id uo13so2842944obb.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=xBiPqHXRW+JX2BeQOKCSK4nSBBQEyrEFjgATfmj/kO0=;
        b=AJdRt3/pUAho0t4v/ZAOFDcuQXCQp5G2cDLdlHnjw3MkkcboxInBUoa4EKTNhD9Fvi
         mcWqUtcdVfglPuyp01uCLGWLhxfGBbOKA/q1a3KZs8q3FA6lf9bgbHkeKflC9csvck7J
         +K+lhBIZGJFvEQa8JX7KbDi+wWEpvPFN3oVbg30eNz4vrwojx/cvrRYNliD7f3IqdpEW
         skR0vuswWFpadufAqhp0LUp8LVAz/jVB4dd5FZ/NPsnv2AtXlYCj7Mey90hWBIW5T1kd
         j7vRaUKqSI6YcIFYaFZe/Ld9EQXy1ETQXNwcSspbgAcXctMl+dxoqBfj+wu5x8yOP/di
         Rtvg==
Received: by 10.60.29.228 with SMTP id n4mr2271022oeh.27.1345754747054; Thu,
 23 Aug 2012 13:45:47 -0700 (PDT)
Received: by 10.182.48.34 with HTTP; Thu, 23 Aug 2012 13:45:26 -0700 (PDT)
In-Reply-To: <CACBZZX6SVSn17nfSarQC1qgz-TxcDDn5tvHb0BkyW9S8DcLY4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204170>

On Thu, Aug 23, 2012 at 6:28 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I'm planning on using Git for a deployment process where the steps ar=
e
> basically:
>
>  1. You log into a deployment host, cd into software.git, do git pull
>  2. A tool runs "make" for you, creates a deployment-YYYYMMDD-HHMMSS =
tag
>  3. That make step will create a bunch of generated (text) files
>  4. Get a list of these with : git clean -dxfn
>  5. Copy those to to software-generated.git, removing any that we
> didn't just create, adding any that are new
>  6. Commit that, tag it with generated-deployment-YYYYMMDD-HHMMSS
>  7. Push out both our generated software.git and
> software-generated.git tag to our servers
>  8. git reset --hard both of those to our newly pushed out tags
>  9. Do git clean -dxf on software.git remove old generated files
>  10. Copy new generated files from generated-software.git to software=
=2Egit
>  11. Restart our application to pick up the new software
>
> For this I'll need to write some "git snapshot-commit" tool for #5 an=
d
> #6 to commit whatever the current state of the directory is (with
> removed/added files), and hack up something to do #9-#10.
>
> This should all be relatively easy, I was just wondering if there was
> any prior art on this that I could use instead of hacking it up
> myself.

Here's a quick hack that does #4-6 but not #9-10 yet, although that
would be easy: https://gist.github.com/3440792

Suggestions for improvements welcome, particularly whether there's a
simpler way to do this to nuke existing files in a repo and replace it
with new files all staged for commit:

    # Go to the target repository, nuke anything already there
    chdir $to_repository;
    system "git reset --hard";
    system "git clean -dxf";
    system "git ls-tree --name-only HEAD -z | xargs -0 rm -rf";
    system "git add --update"; # stage any removals

=46ollowed by:

    system "tar xvf incoming.tar";
    system "rm incoming.tar";
    system "git add * .??* || :"; # Might die if we empty the repo,
TODO: make this use status -> add each file
    system "git commit -m'Bump copy from $from_repository to
$to_repository' || :"; # We might have nothing to change!
