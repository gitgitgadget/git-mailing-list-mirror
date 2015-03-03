From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: weaning distributions off tarballs: extended verification of git tags
Date: Tue, 3 Mar 2015 07:42:09 +0700
Message-ID: <CACsJy8ALQ=Hs2vnpiNxbp-n_sZvNahhtE4N2H-4_Jma4yo6rVQ@mail.gmail.com>
References: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>
 <CANv4PNmF9sTh8od9xT5tYTOF1Cv0Mev2Muf-qxQDS_6kE7EnOw@mail.gmail.com>
 <1425316197.895196.234425829.536E6C06@webmail.messagingengine.com>
 <20150302181230.GA31798@kitenet.net> <CACsJy8C3=f=esBrHE8OudSa0nUbCrLaYJtLC2in3p+tcc-d9bw@mail.gmail.com>
 <xmqqsidn7ymg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joey Hess <id@joeyh.name>, GIT Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 01:42:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSav7-0006Us-J0
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 01:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbbCCAml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 19:42:41 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33278 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108AbbCCAmk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 19:42:40 -0500
Received: by iecar1 with SMTP id ar1so52980758iec.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 16:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1zTHSU3QmdqwqWYUAp9GClt51MCOFxfMCR3cC54UU04=;
        b=jovxRvN0QMt3uPgibxws3AG6m/kfYy0OwEOCa///OgXufqH/KpE2oy+pZNh1rW5Pny
         yPSfiuoQljLkPjk51xz+wfXt8+03tkTGvzGDPk7fSN+NKVoStmwKzUrfLmAuvHt6ybSS
         yknUimPiCwQh/nZqCvU1sYmzZmLECgSBKAW9L5QktlCjnhYwTSGZFcIHKbc228BfAeCq
         fUhYmPn2WfENFTdX5pNwPKe1LGekISl1K0QVdu32KHPIyEldIuzAY25AntCm2cp3pH0e
         mVwrnhNs5e8kzjTGgGPWsZztLXCLvaguza5dVnuH2tRKuF9RSoNgX9eQM/FQyrjfK9wx
         Rsag==
X-Received: by 10.107.155.131 with SMTP id d125mr41178811ioe.17.1425343359955;
 Mon, 02 Mar 2015 16:42:39 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 2 Mar 2015 16:42:09 -0800 (PST)
In-Reply-To: <xmqqsidn7ymg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264638>

On Tue, Mar 3, 2015 at 6:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Tue, Mar 3, 2015 at 1:12 AM, Joey Hess <id@joeyh.name> wrote:
>>> I support this proposal, as someone who no longer releases tarballs
>>> of my software, when I can possibly avoid it. I have worried about
>>> signed tags / commits only being a SHA1 break away from useless.
>>>
>>> As to the implementation, checksumming the collection of raw objects is
>>> certainly superior to tar. Colin had suggested sorting the objects by
>>> checksum, but I don't think that is necessary. Just stream the commit
>>> object, then its tree object, followed by the content of each object
>>> listed in the tree, recursing into subtrees as necessary. That will be a
>>> stable stream for a given commit, or tree.
>>
>> It could be simplified a bit by using ls-tree -r (so you basically
>> have a single big tree). Then hash commit, ls-tree -r output and all
>> blobs pointed by ls-tree in listed order.
>
> What problem are you trying to solve here, though, by deliberately
> deviating what Git internally used to store these objects?  If it is
> OK to ignore the tree boundary, then you probably do not even need
> trees in this secondary hash for validation in the first place.
>
> For example, you can hash a stream:
>
>     <commit object contents> +
>     N * (<pathname> + NUL + <blob object contents>)
>
> as long as the <pathname>s are sorted in a predictable order (like
> in "the index order") in the output.  That would be even simpler (I
> am not saying it is necessarily better, and by inference neither is
> your "simplification").

I did nearly that [1]. But this morning I realized trees carry file
permission. We should keep that in the final checksum as well.

> Now, if the final objective is to replace signature of tarballs,
> does it matter to cover the commit object, or is it sufficient to
> cover the tree contents?
>
> Among the ideas raised so far, I like what Joey suggested, combined
> with "each should have '<type> <length>NUL' header" from Sam Vilain
> the best.  That is, hash the stream:
>
>     "commit <length>" NUL + <commit object contents> +
>     "tree <length>" NUL + <top level tree contents> +
>     ... list the entries in the order you would find by
>     ... some defined traversal order people can agree on.
>
> with whatever the preferred strong hash function of the age.

A bit harder to script, but simpler to provide from cat-file, I think.

[1] http://article.gmane.org/gmane.comp.version-control.git/260211
-- 
Duy
