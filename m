X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Sun, 10 Dec 2006 19:10:16 +0100
Organization: At home
Message-ID: <elhidr$tr3$1@sea.gmane.org>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <8aa486160612100706y92bc722n93374e394fc58005@mail.gmail.com> <28E2300C-8F7A-406F-8FDA-F8786AE95B40@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 10 Dec 2006 18:08:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 43
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33909>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtT6A-0000X6-Rb for gcvg-git@gmane.org; Sun, 10 Dec
 2006 19:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762298AbWLJSIK convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006 13:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762300AbWLJSIK
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 13:08:10 -0500
Received: from main.gmane.org ([80.91.229.2]:41132 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762298AbWLJSIJ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 13:08:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GtT5p-0007gA-5z for git@vger.kernel.org; Sun, 10 Dec 2006 19:08:05 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 19:08:05 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 10 Dec 2006
 19:08:05 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Kyle Moffett wrote:

> The simplest solution which admittedly breaks the ability of older =A0
> GITs to read the data from a file with attributes (ignoring the ext-=20
> attrs themselves) is to create a new "file-with-extended-attributes" =
=A0
> object which contains a binary concatenation (with length bytes and =A0
> attribute names and such) of the file and its extended attributes. =A0=
=20
> That breaks the old GIT assumption that permission and security data =
=A0
> is part of the directory not the file, but it's more in-line with the=
 =A0
> way extended attributes are attached to the inodes in the filesystem =
=A0
> (although that doesn't really matter IMO).

This contradict git philosophy of "tracking contents".

> Alternatively I might be able to add a new entry to each tree object =
=A0
> with invalid extended file mods bits (IE: Neither a directory, a =A0
> file, nor a symlink), or perhaps an entry with an empty name, which =A0
> points to a new "extended attribute table". =A0That table could eithe=
r =A0
> map from (entry, attribute) =3D> (data) or from (entry) =3D> =A0
> ((attribute,data),(attribute,data),[...]), depending on which would =A0
> be more efficient. =A0It's essential that the overhead for non-ext-at=
tr =A0
> repositories is O(1) and ideally the overhead for a bunch of files =A0
> with the same ext-attr is O(size-of-ext-attr) + O(number-of-files-=20
> with-that-attr), although that may vary depending on implementation.

Wouldn't it be better to add another field in the tree object, that
instead of storing "(filemode, link to contents, name)" it would
store "(filemode, link to extended attributes, link to contents, name)"
where "filemode" is mode of a file of which git uses only a few bits
(is a directory, is a symlink, is a file, is a executable file),
and "link to" is sha1 of appropriate blob (or tree) object? Extended
attributes could be stored in new type of object, or just in blob
object. Well, you'd have to extend index in similar way (and add
a way to store extended attributes for directories in index; nowit only
stores info about files).

This of course breaks backwards compatibility...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

