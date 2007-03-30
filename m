From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support comparing blobs (files) with different names
Date: Fri, 30 Mar 2007 09:48:26 +0100
Message-ID: <200703301048.27636.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <200703280158.54929.jnareb@gmail.com> <20070328210301.GA57@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Fri Mar 30 10:45:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXCjl-0004XA-BW
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 10:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454AbXC3Ipa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 30 Mar 2007 04:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933566AbXC3Ipa
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 04:45:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:1452 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933454AbXC3Ip3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 04:45:29 -0400
Received: by ug-out-1314.google.com with SMTP id 44so744032uga
        for <git@vger.kernel.org>; Fri, 30 Mar 2007 01:45:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WMQHZOpWxBmfJU1A7om8Z13VPbsgYH4sKd3nz2fojUjI/kjQs2c8Utu+GsoziRN+NR9zoTT/JJtj4ZqTw3/rlS4Ju5oeYXsUfV135pp8cs+Jy0vz5dnWBIXunpZUrbe0mtr/bw07kubQZV5FAn4QNC+kyXuInRBphXVWwEOyCh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LpO9oAkxvWp1x+u2jGIK9Iqx1i3+HQAmS5dfg7UsH/iGs+flkDSB80u04w+KKUa3MshcuB3BNNOzpWB07vBsCW0t4BnJJmfBmsHNNaSrtAeyVAZW68mLV5wui7PcAqSpx+zVHC3ml/kilDe992TzHUQqTWuLFxrKxpG60cRd2fM=
Received: by 10.82.155.10 with SMTP id c10mr3399495bue.1175244327201;
        Fri, 30 Mar 2007 01:45:27 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id i5sm6536484mue.2007.03.30.01.45.21;
        Fri, 30 Mar 2007 01:45:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070328210301.GA57@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2007 at 23:03 +0200, Martin Koegler wrote:
> On Wed, Mar 28, 2007 at 12:58:54AM +0100, Jakub Narebski wrote:
>> On Thu, Mar 27, 2007, Martin Koegler wrote:
>>> On Tue, Mar 27, 2007 at 01:56:24AM +0100, Jakub Narebski wrote:

>>> If you think, its safe, I can simplify git_blobdiff. I propose
>>> doing the following way (pseudo-code):
>>=20
>>> $file_parent ||=3D $file_name;
>> [...]
>>> $hash=3Dgit_get_hash_by_path($hash_base,$file_name);
>> [...]
>>> $hash_parent=3Dgit_get_hash_by_path($hash_parent_base,$file_parent)=
;
>> [...]
>>>  open $fd, "-|", git_cmd(), "diff", '-p', @diff_opts,
>>>     $hash_parent, $hash
>>>     or die_error(undef, "Open git-diff failed");
>> [...]
>>> Else I will keep a reworked version of my patch.
>>=20
>> The trouble with this is that we may lose mode change (symlink to
>> ordinary file etc.) because we hand-generate %diffinfo.
>=20
> If we need the correct mode in %diffinfo, this is not difficult:
>=20
> $from_mode=3D"blob";
> if (defined $hash_base && defined $file_name)
> ($to_mode,$hash)=3Dgit_get_hash_by_path($hash_base,$file_name);
[...]
> Then we set to_mode and from_mode in %diffinfo to $to_mode and $from_=
mode.
>=20
> git_get_hash_by_path_mode is like git_get_hash_by_path, only that it
> returns an array with the mode and the hash.

I'd rather either have git_get_ls_tree_line_by_path, which we would the=
n
parse using parse_ls_tree_line, or have git_get_info_by_path which woul=
d
return already parsed information (as hash reference, or as a list).

>>>> By the way, if you call git_get_hash_by_path (which is expensive, =
as it
>>>> calls git command), you can use resulting hash in place of
>>>> hash_base:filename as an argument to git-diff.
>>> =20
>>> I must check, if we need to resolve $hash ($hash_parent) by
>>> git_get_hash_by_path, if we construct it out of $hash_base and
>>> $file_name. Maybe we can avoid this call.
>>=20
>> We can use "$hash_base:$file_name" as second parameter to git-diff e=
tc.,
>> but I don't think we want to create links with "$hash_base:$file_nam=
e"
>> instead of SHA-1 id (hash) of a blob as 'h' parameter.
>>=20
>> It can be first implementation, thought, and later we can try to use
>> "index <hash>..<hash> <mode>" lines from extended header to get $has=
h
>> and $hash_parent (with exception of pure rename, but then we need on=
ly
>> one invocation of git_get_hash_by_path subroutine).
>=20
> The <mode> must be discarded, as it is wrong for anything which as no=
t
> a mode of 100644, as we specify a two blob as parameter to git-diff.

The <mode> information might be discarded, or might be saved. "blob"
can have 100644 mode, can have 100755 mode (executable file), or can
have 120000 mode (symbolic link).
=20
>> But I think it is better left for later patch.
>=20
> As git_patchset_body requires an information about the compared file
> as parameter, a new formating function will be needed. I'm not sure,
> if the overhead of git_get_hash_by_path is this worth. Additionally,
> if we have the hash passed by parameter in most cases, there is no
> need to call it in these cases.

git_patchset_body currently buffers (caches) diff header (up to=20
from-file / to-file header) to catch situation where one "raw" format
line (one difftree line) correspond to two patches (like e.g. type chan=
ge
situation below, from ordinary file to symlink or vice versa, and which
_should_ be handled by git_patchset_body). So I think it would not be
hard to parse extended diff header and fill values which are not presen=
t
in %diffinfo from extended diff header. This includes filling $from_has=
h
and $to_hash ($hash_parent and $hash) information from the=20
"index <hash>..<hash> <mode>" or "index <hash>..<hash>" extended diff
header line.

The (only?) rare exception is when files (blobs) does _not_ differ, as
patch in this situation is empty, and we would have to get hash of blob
(which would be the same for from and to, for $hash_parent and $hash)
using git_get_hash_by_name or new git_get_info_by_name.

> Blobdiff (html output) in its current version can not handle symlinks=
:

I'd investigate that. Is "commitdiff" view correct in this situation?

>> diff --git a/x b/x
>> deleted file mode 100644 (file)
>> index 190a180..873fb8d
>> --- a/x
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -123
>> diff --git a/ b/
>> new file mode 120000 (symlink)
>> index 190a180..873fb8d
>> --- /dev/null
>> +++ b/
>> @@ -0,0 +1 @@
>> +file3
>> \ No newline at end of file
>=20
> This was generated by "diff to current" in the history view of a file=
,
> which was changed between symlink and normal file.


> Additionally, to_mode and from_mode of %diffinfo seem to be ignored b=
y
> git_patchset_body.

As it should, I think.

> mfg Martin K=F6gler
> PS:
> I created a blob with a "strange" filename: &()=3D!"=A7$%[<>]*#+_;.
> In the result of the blob view, the " is not escaped in the filename =
in the header
> and a strange content type is returned:
>=20
> $ telnet localhost 80
> Trying 127.0.0.1...
> Connected to localhost.
> Escape character is '^]'.
> GET /gitweb/gitweb.cgi?p=3Dt/.git;a=3Dblob;f=3D%26()%3D%21%22%A7%24%2=
5%5B%3C%3E%5D%2A%23%2B_%3B.;hb=3D7bfed2588bee66b33db544830606fa6606478f=
d9 HTTP/1.0
>=20
> HTTP/1.1 200 OK
> Date: Wed, 28 Mar 2007 19:55:36 GMT
> Server: Apache
> Content-disposition: inline; filename=3D"&()=3D!"=C2=A7$%[<>]*#+_;."
> Expires: Thu, 29 Mar 2007 19:55:39 GMT
> Connection: close
> Content-Type: application/vnd.mif
>=20
> xx

I'd try to check that

--=20
Jakub Narebski
Poland
