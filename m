From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH v2 11/11] vcs-svn,svn-fe: add an option to write svnrev notes
Date: Thu, 28 Jul 2011 12:03:42 +0600
Message-ID: <CA+gfSn9MGiBJ-vhj25wMa5Jwu0hWo0Uyv2wiYst09+M6VX1SQA@mail.gmail.com>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
	<1310559673-5026-12-git-send-email-divanorama@gmail.com>
	<20110725213923.GC8708@elie.dc0b.debconf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 08:03:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmJhE-0002vM-ES
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 08:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab1G1GDo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 02:03:44 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34396 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab1G1GDn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 02:03:43 -0400
Received: by qyk9 with SMTP id 9so1353343qyk.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 23:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8oJeq3/vU1mgVA+7nNlBBRKNQD9KMycZNUOwQXd4IIg=;
        b=THrN1YTf7X8faSNuTxiG+a48ylnom5ko19W7A2lITGpg4NQSeHfJel1puvIn/llK/+
         rtJnJee4jWmMMYu8sRmqs53IujHiEHL7Ts6AUaSvx7MELV4vlvXBPYxeTdkKub4S7PJq
         yyw+hs67fbl1zteKMY+8J27/1hj9GA9O7e8UY=
Received: by 10.229.213.208 with SMTP id gx16mr157878qcb.150.1311833022284;
 Wed, 27 Jul 2011 23:03:42 -0700 (PDT)
Received: by 10.229.189.3 with HTTP; Wed, 27 Jul 2011 23:03:42 -0700 (PDT)
In-Reply-To: <20110725213923.GC8708@elie.dc0b.debconf.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178041>

Sorry for a way too slow response. This patch is probably the most
unbaked one, so I'll start here.

On Tue, Jul 26, 2011 at 3:39 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,
>
> Dmitry Ivankov wrote:
>
>> There are already a few options to determine svn revision from which
>> a git commit imported with svn-fe came from. One is to make svn-fe
>> write a git-svn-id: line to commit messages. Another one is to calc
>> distance to the root commit. The former includes a "url" and is for
>> git-svn compatibility, the latter is obviously slow and a bit fragil=
e.
>>
>> $ svn-fe --notes_ref=3Dnotes_tree --ref=3Dbranch...
>> will write annotations for branch commits to the notes_tree, each
>> annotation is a simple "rN" string. Then these annotations can be
>> viewed manually or used in incremental import to detect the last
>> imported revision or to (re)create the import marks for further
>> imports.
>
> Wouldn't another way be to look at the mark numbers?
If marks file is absent (after clone for example), we'll need to look
at notes anyway.
If it is present and has a mark for latest revision we can hope it is
valid and not
regenerate it.
If for some reason notes are lost and marks are present, it's possible
to recreate
notes from marks though, at least "rN" ones.

> I am not sure I like this. =A0svn-fe is supposed to be a generally
> useful tool, and this patch hard-codes the particular note format rN.
> If it is needed, maybe it would be possible to do something like
>
> =A0 =A0 =A0 =A0--notes-ref=3Drefs/notes/svn-rev --note=3D'project foo=
, r%N'
>
> As a bonus, that would allow including more information using
> different flag characters in the note in the future.
=46ormat string looks nice. While the whole notes thing may need
more thinking.
The main reason I wrote these in svn-fe is that it's more atomic
to write note just after writing a commit. Also "checkpoint" will
create notes for current status (and will write marks too, but weren't
we going to consider notes as a primary data copy? it can be cloned
for example).

One more consideration is that copy-from information most likely
will be written by svn-fe (nothing else knows it anyway) to some
notes, so we'll need some notes writing in svn-fe.
