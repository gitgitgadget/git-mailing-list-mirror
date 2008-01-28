From: Sam Vilain <sam@vilain.net>
Subject: [RFC] Authenticate push via PGP signature, not SSH
Date: Mon, 28 Jan 2008 17:12:01 +1300
Message-ID: <479D5611.4010205@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 05:12:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJLMf-0006e4-He
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 05:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbYA1EMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 23:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbYA1EMO
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 23:12:14 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:54864 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbYA1EMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 23:12:13 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 9941A21D181; Mon, 28 Jan 2008 17:12:07 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id E335321D178
	for <git@vger.kernel.org>; Mon, 28 Jan 2008 17:12:01 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71849>

I recently sent this to the gitorious list; I knocked up a working
system for this, and it so far seems workable, and it is now topical.

Note that the design used by the proof of concept would not be suitable
for the upcoming versions of git which do not allow pushing tags to
branch refs - they would require calling the tags something like
refs/tags/heads/master or some other suitable convention.  Probably not
even using refs/tags etc, to avoid races.

The key idea is to reject pushes if the PGP signature cannot be verified.

Connect to this data - http://www.rubin.ch/wotsap/ - and give everyone
in the world with a working and well signed PGP key secure push access
without them having to set anything up.  Of course, you would also want
to layer on top of this rules that would force unknown contributors into
a "mob"-like namespace.

When heads are pushed, the signed tags that are moved from refs/heads/
foo can be saved in an "archive" tag space, such as under refs/audit/
KEYID/ - this will allow, in the case of a network of git servers, for
servers to synchronise from each other, even when they
don't trust each other.

The update hook first verifies the signature, and rejects the signature
if not accepted:

------8<------
#!/bin/sh
#
# An example hook script to require all pushes be signed
#

ref=$1
sha1_old=$2
sha1_new=$3

if [ -d "$GIT_DIR/keyring" ]; then
        echo "pgp-git: using repository keyring" >&2
        GNUPGHOME=$GIT_DIR/keyring
        export GNUPGHOME
else
        echo "pgp-git: using default keyring" >&2
fi

set -e

case $ref in
        refs/tags/tmp/*)
                echo "E:Even TRYING that lark makes me ANGRY!" >&2
                exit 38
                ;;

        refs/heads/*|refs/tags/*)
                audit=$(echo "$ref" | sed 's!refs/!refs/tags/tmp/!')
                tagname=$(echo "$audit" | sed 's!refs/tags!!')
                git update-ref -m "update hook" \
                        "$audit" $sha1_new
                ;;

        *)
                echo "E:WHOA!  Pushing to $ref?" >&2
                exit 1
                ;;
esac

trap "git-tag -d $tagname" ERR
git-tag -v "$tagname"
------8<------

And then, the post-update hook will move the tag into the designed place;

------8<------
#!/bin/sh
#
# An example hook script to prepare a packed repository for use over
# dumb transports.
#
# To enable this hook, make this file executable by "chmod +x post-update".

for ref
do
        case "$ref" in
                refs/heads/*)
                        type=$(git cat-file -t $ref)
                        if [ $type = "tag" ]
                        then
                                echo "pgp-git: removing dummy tag" >&2
                                git update-ref -m "post-update hook -
remove dummy tag" "$ref" "$ref^{commit}"
                        fi

                        ;;
                *);;
        esac
done

git-update-server-info
------8<------

This does force potential contributors to get PGP keys, and get them
signed - but that seems to me to be a reasonable barrier of entry and
may even help drive some PGP adoption.

Remember this is a proof of concept, so let's discuss the design first
and not worry too much about the glaring bugs yet.

Sam.
