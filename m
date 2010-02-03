From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 3 Feb 2010 14:47:33 -0500
Message-ID: <32541b131002031147r367ee08fxc64c4c54165953a3@mail.gmail.com>
References: <ron1-32BD5F.10255403022010@news.gmane.org> <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com> 
	<ron1-5F71CB.11234903022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:48:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NclD7-00042L-5z
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784Ab0BCTsU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 14:48:20 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:45361 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932770Ab0BCTsT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 14:48:19 -0500
Received: by gxk24 with SMTP id 24so2174960gxk.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 11:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=AcUdMIbw9VMJiHPJYEohJaovGClM4RFcdhPue8Gce+I=;
        b=o0vqfkJeTJYmvB3eAyJyR9Q/F87g8J9LhHXSyk4BXZnpKyC7uNtOMA6JJamQ0mwGno
         AjxRlxY9sf8pcNhz+e7z/zlivlafcYPFiRo2cyG94q3f+lFbDHFpfpKXfuP/rYWbcTpd
         cMgx/kPPKYtgYBqVsIkqrV7jtsS1oaVO6Z7Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bggt+uj4MbmYInNGbvYoiVc3tCejLFLhqv3z/xs0mpv4G+2P6moa/eKnws53CqrrI8
         jdoRNCN6X+6pD4Y2Vl/0tFNuvTzQi6V/HmlMdZXdwLZ1mkAvPF9GW3EaaiwjnT7kBwYH
         748yBlNEVcBt/4sHv7QXbGgpJiscyw/n8ioy0=
Received: by 10.150.239.14 with SMTP id m14mr468249ybh.305.1265226473058; Wed, 
	03 Feb 2010 11:47:53 -0800 (PST)
In-Reply-To: <ron1-5F71CB.11234903022010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138873>

On Wed, Feb 3, 2010 at 2:23 PM, Ron Garret <ron1@flownet.com> wrote:
> In article
> Ah. =A0That explains everything. =A0Thanks. =A0(I thought git mv was
> equivalent to git rm followed by git add. =A0But it's not.)

I suppose in this case it's not.  The only difference is when your
work tree differs from your index, though, and it's to be expected
that 'git rm', in removing things from the index, would lose your
ability to track those differences.

> So... how *does* git decide when two blobs are different blobs and wh=
en
> they are the same blob with mods? =A0I asked this question before and=
 was
> pointed to the diffcore docs, but that didn't really clear things up.
> That just describes all the different ways git can do diffs, not the
> actual heuristics that git uses to track content.

If you really want to know the details, looking at the code really is
probably the best solution; it's not even that long.

The short version is that git chooses a set of candidate blobs, then
diffs them and figures out a percentage similarity between each pair.
(A simple way to think of the similarity index is "how long is the
diff compared to the file itself?"  If the diff is of length zero, the
similarity is 100%, and so on.) If the similarity is greater than a
certain threshold, then it's considered to be the same file.

Choosing the set of candidates is actually the more interesting
problem, since detecting moves using the above algorithm is O(n^2)
with the number of candidates.  That's why 'git diff' and 'git log'
don't do it at all by default.

If you provide -M, the set of candidates is the set of files that were
removed/modified and the set of files that were added.  (Added files
are compared against removed/modified files, iirc.)  Normally that's a
very short list.  With -C, you need to compare all
added/removed/modified files with all others, which is slightly more
work.  With --find-copies-harder, it becomes potentially a *lot* of
work.

Have fun,

Avery
