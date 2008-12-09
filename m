From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: git-bpush: Pushing to a bundle
Date: Tue, 9 Dec 2008 15:58:20 +0100
Message-ID: <adf1fd3d0812090658q14001019re8977b912386c256@mail.gmail.com>
References: <adf1fd3d0812090149m158fcb9as15bacce58c61a1a3@mail.gmail.com>
	 <alpine.DEB.1.00.0812091100470.2916@eeepc-johanness>
	 <adf1fd3d0812090221t2264a4f9i87b5e23be897ee84@mail.gmail.com>
	 <493E545B.6010609@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_72151_30700431.1228834700089"
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git list" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 15:59:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA43p-00054e-Ul
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 15:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbYLIO6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 09:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbYLIO6Y
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 09:58:24 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:43934 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbYLIO6X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 09:58:23 -0500
Received: by qyk4 with SMTP id 4so1889479qyk.13
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 06:58:21 -0800 (PST)
Received: by 10.103.248.17 with SMTP id a17mr88814mus.97.1228834700103;
        Tue, 09 Dec 2008 06:58:20 -0800 (PST)
Received: by 10.103.167.6 with HTTP; Tue, 9 Dec 2008 06:58:20 -0800 (PST)
In-Reply-To: <493E545B.6010609@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102633>

------=_Part_72151_30700431.1228834700089
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2008/12/9 Johannes Sixt <j.sixt@viscovery.net>:
> Santi B=E9jar schrieb:
>> 2008/12/9 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>> On Tue, 9 Dec 2008, Santi B=E9jar wrote:
>>>> while [ $# !=3D 0 ] ; do
>>>>     refs=3D"$refs$LF$1" && shift
>>>> done
>>> That is equivalent to refs=3D"$*", no?
>>
>> Almost, IFS is set to line-feed so I needed to put $LF instead of spaces=
.
>
> But "$*" inserts the first character of IFS (not necessarily spaces), and
> since your IFS *is* $LF, "$*" should do what you want.
>

Oh, you are right.

> Anyway, I found reading your shell script quite hard, because of excessiv=
e
> use of brackets and single line && chains (which lack proper error
> handling, BTW).

I've changed the script to follow the Git's conventions (at least I've
tried),  a few more error handling and some simplification. BTW, what
do you find hard with single line && chains?

I do not sent a diff because it is almost as big as the script itself.
#!/bin/sh

OPTIONS_KEEPDASHDASH=3D
OPTIONS_SPEC=3D"\
git bpush [options] [<remote> [<refs>...]]
--
f,force   force updates
full      create a full bundle
v         be verbose
"
SUBDIRECTORY_OK=3DYes
. git-sh-setup
. git-parse-remote

cd_to_toplevel

LF=3D'
'
IFS=3D"$LF"

bases=3D
bbases=3D
changed=3D
force=3D
nonff=3D
remote=3D
refs=3D
while :
do
=09case "$1" in
=09-v)
=09=09verbose=3Dt ;;
=09--full)
=09=09full=3Dt ;;
=09-f|--force)
=09=09force=3Dt ;;
=09--)
=09=09shift
=09=09break ;;
=09*)
=09=09usage ;;
=09esac
=09shift
done

test -n "$1" && remote=3D$1 && shift
refs=3D"$*"

test -z "$remote" && remote=3D$(get_default_remote)
remoteurl=3D$(git config remote.${remote}.url)
test -z "$remoteurl" && remoteurl=3D$remote
test -d "$remoteurl" && die "$remoteurl is a directory"

# Default bases in bundle.base
# Default {refs,base} can be specified in remote.<remote>.{push,bundlebase}
if test "$remote" !=3D "$remoteurl"
then
=09test -z "$refs" &&
=09refs=3D$(git config --get-all remote.${remote}.push)
=09bases=3D$(git config --get-all remote.${remote}.bundlebase ||
=09=09git config --get-all bundle.base)
else
=09bases=3D$(git config --get-all bundle.base)
fi

# git rev-parse --symbolic-full-name resolves symlinks
# Keep at least HEAD
head=3D
for ref in $refs ; do
=09test "$ref" =3D HEAD && head=3Dt && break
done

test -n "$bases" && bases=3D$(git rev-parse --revs-only $bases | sort -u)

# Full symbolic refs need to be uniq
test -n "$refs" &&
refs=3D$(git-rev-parse --symbolic-full-name --revs-only $refs | sort -u)

test -n "$head" && refs=3D"HEAD$LF$refs"

if test -e "$remoteurl"
then
=09blines=3D$(git bundle verify "$remoteurl" 2>/dev/null) ||
=09die "Verification of \"$remoteurl\" failed"
=09# Find the bundle's bases
=09refs=3D"$refs$LF$(git bundle list-heads $remoteurl | cut -d " " -f 2)"
=09requires=3D
=09for line in $blines
=09do
=09=09case "$requires,$line" in
=09=09",The bundle requires"*)
=09=09=09requires=3Dt ;;
=09=09t,) ;;
=09=09t,*)
=09=09=09bbase=3D$(echo $line | cut -d " " -f 1)
=09=09=09bbases=3D"$bbases$LF$bbase"
=09=09=09;;
=09=09esac
=09done
=09bases=3D"$bases$LF$bbases"
elif test -z "$refs" ; then
=09# Push current branch
=09refs=3D"HEAD$LF$(git symbolic-ref -q HEAD)"
fi

test -z "$refs" && die "No refs to push"

refs=3D$(echo "$refs" | sort -u)

for ref in $bases $refs
do
=09test "$(git cat-file -t $ref^{})" !=3D commit &&
=09die "$(basename $0): $ref is not a commit"
done

header=3D"To $remoteurl"
test -n "$verbose" && echo "Pushing to $remoteurl" && echo $header && heade=
r=3D

# Find what is/is not a fast-forward, up to date or new
# As "git bundle" does not support refspecs we must push all matching branc=
hes
for ref in $refs ; do
=09text=3D
=09bchanged=3D
=09case $ref in
=09refs/tags/*)
=09=09bshort=3D$(echo $ref | sed -e "s|^refs/tags/||")
=09=09newtext=3D"new tag";;
=09refs/heads/*|HEAD)
=09=09bshort=3D$(echo $ref | sed -e "s|^refs/heads/||")
=09=09newtext=3D"new branch" ;;
=09esac
=09newhash=3D$(git rev-parse $ref) || die "Ref $ref not valid"
=09newshort=3D$(git rev-parse --short $ref)
=09bheads=3D
=09test -e "$remoteurl" && bheads=3D"$(git bundle list-heads $remoteurl)"
=09for bhead in $bheads
=09do
=09=09bhash=3D$(echo $bhead | cut -d " " -f 1)
=09=09bref=3D$(echo $bhead | cut -d " " -f 2)
=09=09# Find the matching ref in the bundle
=09=09test "$bref" !=3D "$ref" && continue
=09=09oldshort=3D$(git rev-parse --short $bhash)
=09=09mergebase=3D
=09=09case $ref in
=09=09refs/tags/*)
=09=09=09# Only test if it is different
=09=09=09mergebase=3D$newhash;;
=09=09refs/heads/*|HEAD)
=09=09=09mergebase=3D$(git merge-base $bref $bhash);;
=09=09esac
=09=09case $newhash,$bhash,$mergebase,$force in
=09=09$bhash,$newhash,*)
=09=09=09# No changes
=09=09=09text=3D" =3D [up to date] $bshort -> $bshort"
=09=09=09;;
=09=09*,*,$bhash,*)
=09=09=09# Fast-forward
=09=09=09bchanged=3Dt
=09=09=09text=3D"   $oldshort..$newshort $bshort -> $bshort"
=09=09=09;;
=09=09*,t)
=09=09=09# Forced non fast-forward
=09=09=09bchanged=3Dt
=09=09=09text=3D" + $oldshort...$newshort $bshort -> $bshort (forced update=
)"
=09=09=09;;
=09=09*)
=09=09=09bchanged=3Dt
=09=09=09nonff=3Dt
=09=09=09text=3D" ! [rejected] $bshort -> $bshort (non-fast forward)"
=09=09esac
=09=09break
=09done
=09test -z "$text" && text=3D" * [$newtext] $bshort -> $bshort" && bchanged=
=3Dt
=09if test -n "$bchanged" || test -n "$verbose"
=09then
=09=09test -n "$header" && echo $header && header=3D
=09=09echo $text
=09fi
=09test -n "$bchanged" && changed=3Dt
done

# Recreate the bundle if --full and the current bundle is not full
test -n "$full" && bases=3D && test -n "$bbases" && changed=3Dt

test -n "$nonff" && die "error: failed to push some refs to $remoteurl"
test -z "$changed" && die "Everything up-to-date"
test -n "$bases" && bases=3D"--not$LF$bases"

git bundle create $remoteurl $refs $bases ||
die "Cannot create bundle \"$remoteurl\""

test "$remote" !=3D "$remoteurl" && { git fetch -q "$remote" ||
=09die "Error fetch from bundle \"$remoteurl\"" ; }

exit 0

------=_Part_72151_30700431.1228834700089
Content-Type: application/octet-stream; name=git-bpush
Content-Transfer-Encoding: base64
X-Attachment-Id: f_foio2rz00
Content-Disposition: attachment; filename=git-bpush

IyEvYmluL3NoCgpPUFRJT05TX0tFRVBEQVNIREFTSD0KT1BUSU9OU19TUEVDPSJcCmdpdCBicHVz
aCBbb3B0aW9uc10gWzxyZW1vdGU+IFs8cmVmcz4uLi5dXQotLQpmLGZvcmNlICAgZm9yY2UgdXBk
YXRlcwpmdWxsICAgICAgY3JlYXRlIGEgZnVsbCBidW5kbGUKdiAgICAgICAgIGJlIHZlcmJvc2UK
IgpTVUJESVJFQ1RPUllfT0s9WWVzCi4gZ2l0LXNoLXNldHVwCi4gZ2l0LXBhcnNlLXJlbW90ZQoK
Y2RfdG9fdG9wbGV2ZWwKCkxGPScKJwpJRlM9IiRMRiIKCmJhc2VzPQpiYmFzZXM9CmNoYW5nZWQ9
CmZvcmNlPQpub25mZj0KcmVtb3RlPQpyZWZzPQp3aGlsZSA6CmRvCgljYXNlICIkMSIgaW4KCS12
KQoJCXZlcmJvc2U9dCA7OwoJLS1mdWxsKQoJCWZ1bGw9dCA7OwoJLWZ8LS1mb3JjZSkKCQlmb3Jj
ZT10IDs7CgktLSkKCQlzaGlmdAoJCWJyZWFrIDs7CgkqKQoJCXVzYWdlIDs7Cgllc2FjCglzaGlm
dApkb25lCgp0ZXN0IC1uICIkMSIgJiYgcmVtb3RlPSQxICYmIHNoaWZ0CnJlZnM9IiQqIgoKdGVz
dCAteiAiJHJlbW90ZSIgJiYgcmVtb3RlPSQoZ2V0X2RlZmF1bHRfcmVtb3RlKQpyZW1vdGV1cmw9
JChnaXQgY29uZmlnIHJlbW90ZS4ke3JlbW90ZX0udXJsKQp0ZXN0IC16ICIkcmVtb3RldXJsIiAm
JiByZW1vdGV1cmw9JHJlbW90ZQp0ZXN0IC1kICIkcmVtb3RldXJsIiAmJiBkaWUgIiRyZW1vdGV1
cmwgaXMgYSBkaXJlY3RvcnkiCgojIERlZmF1bHQgYmFzZXMgaW4gYnVuZGxlLmJhc2UKIyBEZWZh
dWx0IHtyZWZzLGJhc2V9IGNhbiBiZSBzcGVjaWZpZWQgaW4gcmVtb3RlLjxyZW1vdGU+LntwdXNo
LGJ1bmRsZWJhc2V9CmlmIHRlc3QgIiRyZW1vdGUiICE9ICIkcmVtb3RldXJsIgp0aGVuCgl0ZXN0
IC16ICIkcmVmcyIgJiYKCXJlZnM9JChnaXQgY29uZmlnIC0tZ2V0LWFsbCByZW1vdGUuJHtyZW1v
dGV9LnB1c2gpCgliYXNlcz0kKGdpdCBjb25maWcgLS1nZXQtYWxsIHJlbW90ZS4ke3JlbW90ZX0u
YnVuZGxlYmFzZSB8fAoJCWdpdCBjb25maWcgLS1nZXQtYWxsIGJ1bmRsZS5iYXNlKQplbHNlCgli
YXNlcz0kKGdpdCBjb25maWcgLS1nZXQtYWxsIGJ1bmRsZS5iYXNlKQpmaQoKIyBnaXQgcmV2LXBh
cnNlIC0tc3ltYm9saWMtZnVsbC1uYW1lIHJlc29sdmVzIHN5bWxpbmtzCiMgS2VlcCBhdCBsZWFz
dCBIRUFECmhlYWQ9CmZvciByZWYgaW4gJHJlZnMgOyBkbwoJdGVzdCAiJHJlZiIgPSBIRUFEICYm
IGhlYWQ9dCAmJiBicmVhawpkb25lCgp0ZXN0IC1uICIkYmFzZXMiICYmIGJhc2VzPSQoZ2l0IHJl
di1wYXJzZSAtLXJldnMtb25seSAkYmFzZXMgfCBzb3J0IC11KQoKIyBGdWxsIHN5bWJvbGljIHJl
ZnMgbmVlZCB0byBiZSB1bmlxCnRlc3QgLW4gIiRyZWZzIiAmJgpyZWZzPSQoZ2l0LXJldi1wYXJz
ZSAtLXN5bWJvbGljLWZ1bGwtbmFtZSAtLXJldnMtb25seSAkcmVmcyB8IHNvcnQgLXUpCgp0ZXN0
IC1uICIkaGVhZCIgJiYgcmVmcz0iSEVBRCRMRiRyZWZzIgoKaWYgdGVzdCAtZSAiJHJlbW90ZXVy
bCIKdGhlbgoJYmxpbmVzPSQoZ2l0IGJ1bmRsZSB2ZXJpZnkgIiRyZW1vdGV1cmwiIDI+L2Rldi9u
dWxsKSB8fAoJZGllICJWZXJpZmljYXRpb24gb2YgXCIkcmVtb3RldXJsXCIgZmFpbGVkIgoJIyBG
aW5kIHRoZSBidW5kbGUncyBiYXNlcwoJcmVmcz0iJHJlZnMkTEYkKGdpdCBidW5kbGUgbGlzdC1o
ZWFkcyAkcmVtb3RldXJsIHwgY3V0IC1kICIgIiAtZiAyKSIKCXJlcXVpcmVzPQoJZm9yIGxpbmUg
aW4gJGJsaW5lcwoJZG8KCQljYXNlICIkcmVxdWlyZXMsJGxpbmUiIGluCgkJIixUaGUgYnVuZGxl
IHJlcXVpcmVzIiopCgkJCXJlcXVpcmVzPXQgOzsKCQl0LCkgOzsKCQl0LCopCgkJCWJiYXNlPSQo
ZWNobyAkbGluZSB8IGN1dCAtZCAiICIgLWYgMSkKCQkJYmJhc2VzPSIkYmJhc2VzJExGJGJiYXNl
IgoJCQk7OwoJCWVzYWMKCWRvbmUKCWJhc2VzPSIkYmFzZXMkTEYkYmJhc2VzIgplbGlmIHRlc3Qg
LXogIiRyZWZzIiA7IHRoZW4KCSMgUHVzaCBjdXJyZW50IGJyYW5jaAoJcmVmcz0iSEVBRCRMRiQo
Z2l0IHN5bWJvbGljLXJlZiAtcSBIRUFEKSIKZmkKCnRlc3QgLXogIiRyZWZzIiAmJiBkaWUgIk5v
IHJlZnMgdG8gcHVzaCIKCnJlZnM9JChlY2hvICIkcmVmcyIgfCBzb3J0IC11KQoKZm9yIHJlZiBp
biAkYmFzZXMgJHJlZnMKZG8KCXRlc3QgIiQoZ2l0IGNhdC1maWxlIC10ICRyZWZee30pIiAhPSBj
b21taXQgJiYKCWRpZSAiJChiYXNlbmFtZSAkMCk6ICRyZWYgaXMgbm90IGEgY29tbWl0Igpkb25l
CgpoZWFkZXI9IlRvICRyZW1vdGV1cmwiCnRlc3QgLW4gIiR2ZXJib3NlIiAmJiBlY2hvICJQdXNo
aW5nIHRvICRyZW1vdGV1cmwiICYmIGVjaG8gJGhlYWRlciAmJiBoZWFkZXI9CgojIEZpbmQgd2hh
dCBpcy9pcyBub3QgYSBmYXN0LWZvcndhcmQsIHVwIHRvIGRhdGUgb3IgbmV3CiMgQXMgImdpdCBi
dW5kbGUiIGRvZXMgbm90IHN1cHBvcnQgcmVmc3BlY3Mgd2UgbXVzdCBwdXNoIGFsbCBtYXRjaGlu
ZyBicmFuY2hlcwpmb3IgcmVmIGluICRyZWZzIDsgZG8KCXRleHQ9CgliY2hhbmdlZD0KCWNhc2Ug
JHJlZiBpbgoJcmVmcy90YWdzLyopCgkJYnNob3J0PSQoZWNobyAkcmVmIHwgc2VkIC1lICJzfF5y
ZWZzL3RhZ3MvfHwiKQoJCW5ld3RleHQ9Im5ldyB0YWciOzsKCXJlZnMvaGVhZHMvKnxIRUFEKQoJ
CWJzaG9ydD0kKGVjaG8gJHJlZiB8IHNlZCAtZSAic3xecmVmcy9oZWFkcy98fCIpCgkJbmV3dGV4
dD0ibmV3IGJyYW5jaCIgOzsKCWVzYWMKCW5ld2hhc2g9JChnaXQgcmV2LXBhcnNlICRyZWYpIHx8
IGRpZSAiUmVmICRyZWYgbm90IHZhbGlkIgoJbmV3c2hvcnQ9JChnaXQgcmV2LXBhcnNlIC0tc2hv
cnQgJHJlZikKCWJoZWFkcz0KCXRlc3QgLWUgIiRyZW1vdGV1cmwiICYmIGJoZWFkcz0iJChnaXQg
YnVuZGxlIGxpc3QtaGVhZHMgJHJlbW90ZXVybCkiCglmb3IgYmhlYWQgaW4gJGJoZWFkcwoJZG8K
CQliaGFzaD0kKGVjaG8gJGJoZWFkIHwgY3V0IC1kICIgIiAtZiAxKQoJCWJyZWY9JChlY2hvICRi
aGVhZCB8IGN1dCAtZCAiICIgLWYgMikKCQkjIEZpbmQgdGhlIG1hdGNoaW5nIHJlZiBpbiB0aGUg
YnVuZGxlCgkJdGVzdCAiJGJyZWYiICE9ICIkcmVmIiAmJiBjb250aW51ZQoJCW9sZHNob3J0PSQo
Z2l0IHJldi1wYXJzZSAtLXNob3J0ICRiaGFzaCkKCQltZXJnZWJhc2U9CgkJY2FzZSAkcmVmIGlu
CgkJcmVmcy90YWdzLyopCgkJCSMgT25seSB0ZXN0IGlmIGl0IGlzIGRpZmZlcmVudAoJCQltZXJn
ZWJhc2U9JG5ld2hhc2g7OwoJCXJlZnMvaGVhZHMvKnxIRUFEKQoJCQltZXJnZWJhc2U9JChnaXQg
bWVyZ2UtYmFzZSAkYnJlZiAkYmhhc2gpOzsKCQllc2FjCgkJY2FzZSAkbmV3aGFzaCwkYmhhc2gs
JG1lcmdlYmFzZSwkZm9yY2UgaW4KCQkkYmhhc2gsJG5ld2hhc2gsKikKCQkJIyBObyBjaGFuZ2Vz
CgkJCXRleHQ9IiA9IFt1cCB0byBkYXRlXSAkYnNob3J0IC0+ICRic2hvcnQiCgkJCTs7CgkJKiwq
LCRiaGFzaCwqKQoJCQkjIEZhc3QtZm9yd2FyZAoJCQliY2hhbmdlZD10CgkJCXRleHQ9IiAgICRv
bGRzaG9ydC4uJG5ld3Nob3J0ICRic2hvcnQgLT4gJGJzaG9ydCIKCQkJOzsKCQkqLHQpCgkJCSMg
Rm9yY2VkIG5vbiBmYXN0LWZvcndhcmQKCQkJYmNoYW5nZWQ9dAoJCQl0ZXh0PSIgKyAkb2xkc2hv
cnQuLi4kbmV3c2hvcnQgJGJzaG9ydCAtPiAkYnNob3J0IChmb3JjZWQgdXBkYXRlKSIKCQkJOzsK
CQkqKQoJCQliY2hhbmdlZD10CgkJCW5vbmZmPXQKCQkJdGV4dD0iICEgW3JlamVjdGVkXSAkYnNo
b3J0IC0+ICRic2hvcnQgKG5vbi1mYXN0IGZvcndhcmQpIgoJCWVzYWMKCQlicmVhawoJZG9uZQoJ
dGVzdCAteiAiJHRleHQiICYmIHRleHQ9IiAqIFskbmV3dGV4dF0gJGJzaG9ydCAtPiAkYnNob3J0
IiAmJiBiY2hhbmdlZD10CglpZiB0ZXN0IC1uICIkYmNoYW5nZWQiIHx8IHRlc3QgLW4gIiR2ZXJi
b3NlIgoJdGhlbgoJCXRlc3QgLW4gIiRoZWFkZXIiICYmIGVjaG8gJGhlYWRlciAmJiBoZWFkZXI9
CgkJZWNobyAkdGV4dAoJZmkKCXRlc3QgLW4gIiRiY2hhbmdlZCIgJiYgY2hhbmdlZD10CmRvbmUK
CiMgUmVjcmVhdGUgdGhlIGJ1bmRsZSBpZiAtLWZ1bGwgYW5kIHRoZSBjdXJyZW50IGJ1bmRsZSBp
cyBub3QgZnVsbAp0ZXN0IC1uICIkZnVsbCIgJiYgYmFzZXM9ICYmIHRlc3QgLW4gIiRiYmFzZXMi
ICYmIGNoYW5nZWQ9dAoKdGVzdCAtbiAiJG5vbmZmIiAmJiBkaWUgImVycm9yOiBmYWlsZWQgdG8g
cHVzaCBzb21lIHJlZnMgdG8gJHJlbW90ZXVybCIKdGVzdCAteiAiJGNoYW5nZWQiICYmIGRpZSAi
RXZlcnl0aGluZyB1cC10by1kYXRlIgp0ZXN0IC1uICIkYmFzZXMiICYmIGJhc2VzPSItLW5vdCRM
RiRiYXNlcyIKCmdpdCBidW5kbGUgY3JlYXRlICRyZW1vdGV1cmwgJHJlZnMgJGJhc2VzIHx8CmRp
ZSAiQ2Fubm90IGNyZWF0ZSBidW5kbGUgXCIkcmVtb3RldXJsXCIiCgp0ZXN0ICIkcmVtb3RlIiAh
PSAiJHJlbW90ZXVybCIgJiYgeyBnaXQgZmV0Y2ggLXEgIiRyZW1vdGUiIHx8CglkaWUgIkVycm9y
IGZldGNoIGZyb20gYnVuZGxlIFwiJHJlbW90ZXVybFwiIiA7IH0KCmV4aXQgMAo=
------=_Part_72151_30700431.1228834700089--
