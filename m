From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: difftool, open all diff files immediately, not in serial
Date: Tue, 4 Aug 2009 23:47:46 +0200
Message-ID: <200908042347.48705.trast@student.ethz.ch>
References: <loom.20090804T204107-117@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Seba Illingworth <seba.illingworth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:48:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYRs1-0004Ui-Mb
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 23:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbZHDVsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 17:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbZHDVsX
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 17:48:23 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:52829 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932614AbZHDVsX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 17:48:23 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 4 Aug
 2009 23:48:23 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 4 Aug
 2009 23:48:00 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <loom.20090804T204107-117@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124820>

Seba Illingworth wrote:
> The default git diff behavior is to open each diff file in serial 
> (wait for previous file to be closed before opening next file).
> 
> I'm looking for a way to open all the files at once - in BeyondCompare 
> for example this would open all the files in tabs within the same BC window.

I posted the script below on IRC the other week[1] in reply to someone
looking for a way to do this for 'meld'.  I'm not sure this is the
*fastest* way to do this, but I'm at least trying to take a few
shortcuts ;-)

Since this is now the second request for such a tool, it would be nice
if you could at least shape this as a contrib/ patch (if it fits your
needs, of course).

[1] http://colabti.org/irclogger/irclogger_log/git?date=2009-07-14#l2180

-- 8< --
#!/bin/sh

. "$(git --exec-path)/git-sh-setup"
cd_to_toplevel # for the tar below

pre="${1-HEAD}"
post="$2"

tmp="$(mktemp -d)"

cleanup () {
	rm -rf $tmp
}

trap cleanup EXIT

mkdir "$tmp"/a "$tmp"/b

if [ -n "$post" ]; then
	git diff --name-only "$pre" "$post" > "$tmp"/filelist
	while read name; do
		mkdir -p "$tmp"/b/"$(dirname "$name")"
		git show "$post":"$name" > "$tmp"/b/"$name"
	done < "$tmp"/filelist
else
	git diff --name-only "$pre" > "$tmp"/filelist
	tar -c -T "$tmp"/filelist | (cd "$tmp"/b && tar -x)
fi

while read name; do
	mkdir -p "$tmp"/a/"$(dirname "$name")"
	git show "$pre":"$name" > "$tmp"/a/"$name"
done < "$tmp"/filelist

cd "$tmp"
#meld a b
diff -ur a b
