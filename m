From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 1 Feb 2011 08:33:53 -0800
Message-ID: <AANLkTikri2A_WqSB1nd=SZ5NZR6hbsxSy-ziYVcPUSxy@mail.gmail.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com> <AANLkTinJVa++tttPDav1g1+w128fWsouM=+gf14eUOOK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 17:34:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkJBO-0003py-CY
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 17:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab1BAQeQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 11:34:16 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33288 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab1BAQeQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 11:34:16 -0500
Received: by ywe10 with SMTP id 10so2538908ywe.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 08:34:15 -0800 (PST)
Received: by 10.103.241.16 with SMTP id t16mr3074903mur.23.1296578054142; Tue,
 01 Feb 2011 08:34:14 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Tue, 1 Feb 2011 08:33:53 -0800 (PST)
In-Reply-To: <AANLkTinJVa++tttPDav1g1+w128fWsouM=+gf14eUOOK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165822>

On Tue, Feb 1, 2011 at 07:52, Nguyen Thai Ngoc Duy <pclouds@gmail.com> =
wrote:
> On Tue, Feb 1, 2011 at 8:51 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> On Sun, 30 Jan 2011, Jonathan Nieder wrote:
>>> > support for tracking empty directories
>>>
>>> Tricky to get the UI right. =A0I am interested in and would be glad=
 to
>>> help with this one.
>>
>> Also one needs to remember that this would require adding extension
>> to git index, because currently it tracks only files, and not
>> directories. =A0Explicitly tracking directories in the index could b=
e
>> useful for other purposes...
>>
>> The major difficulty of this is IMHO not the UI, but tracking all th=
ose
>> tricky corner cases (like directory/file conflict, etc.).
>
> Sort order in index is quite special/strange and must be handled
> correctly when dirs and files are mixed.

Its not the order in the index that is confusing, its the order in the
tree objects.  The index sort order is simple, since every path is a
full path string from the top of the repository... you use strcmp() to
order them into a natural order.  This however skews where a
subdirectory should live relative to a sibling file, because the
"subdirectory" sorts as though its name ends with '/'.

> There are already special
> directories in index: the submodules. Current git code treats
> S_ISDIR() and S_ISGITLINK() the same in ce_to_dtype() and some more
> places. You need to decouple it somehow.

More confusingly, the GITLINK type is handled as though its *not* a
directory.  Storing an empty directory probably means tracking it like
a real directory, but using the empty tree SHA-1 as its value.
Otherwise we probably have all sorts of stuff broken.

> I tried this (for another purpose) and pulled back. I recall Shawn ha=
d
> a tree-based index implementation, don't know if he still has it.

No, we threw out the tree-based index that was used inside of EGit
years ago.  It turned out to be a horrible idea because it wasn't
compatible with the C tools, and it didn't have the inode stat cache
to tell us which files were clean or dirty quickly.

> Actually tree-based index with dictionary (something like trees in
> packv4) is a good feature itself. It could shrink index size down a
> lot. index is frequently read/written so small index helps (webkit's
> index is 16M, 4M after gzipped).

I think a lot of the reason the webkit index is 16M, gzip to 4M is
because of the duplicate path prefixes that appear on all files within
the same directory.  If the index was still a single file, but was
organized into sections by tree (like the TREE extension within the
index itself) you could avoid having the full path within the index
file and save a lot of space when there are many files within
subdirectories.  But this does complicate the C code because you would
need to copy each of those path segments together into a path buffer
in order to access the file in the working tree.

Its probably faster to copy those path segments on read into a big
path buffer, and break them apart on write, than to have a huge index
file.  We already reformat the index during reading/writing to expand
some of the fields for in-memory only flags.

--=20
Shawn.
