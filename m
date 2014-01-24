From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Fri, 24 Jan 2014 18:36:36 -0500
Message-ID: <20140124233635.GA31371@sigill.intra.peff.net>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com>
 <xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
 <CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
 <52DFE882.2040605@atlas-elektronik.com>
 <xmqq7g9syp1m.fsf@gitster.dls.corp.google.com>
 <CAFFjANTNLnc4GcVeSEvuWpfYVXJchJqkHwvUVdREdXmWx6e4=Q@mail.gmail.com>
 <xmqqlhy7yjjp.fsf@gitster.dls.corp.google.com>
 <20140122203030.GB14211@milliways>
 <20140123020913.GF17254@sigill.intra.peff.net>
 <xmqqha8uva2i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ken Moffat <zarniwhoop@ntlworld.com>,
	Vicent =?utf-8?B?TWFydMOt?= <tanoku@gmail.com>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Sat Jan 25 00:36:53 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1W6qIt-0001Vn-Nv
	for glk-linux-kernel-3@plane.gmane.org; Sat, 25 Jan 2014 00:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbaAXXgl (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 24 Jan 2014 18:36:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:38457 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750903AbaAXXgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jan 2014 18:36:38 -0500
Received: (qmail 17099 invoked by uid 102); 24 Jan 2014 23:36:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Jan 2014 17:36:38 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jan 2014 18:36:36 -0500
Content-Disposition: inline
In-Reply-To: <xmqqha8uva2i.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241054>

On Thu, Jan 23, 2014 at 10:15:33AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Junio, since you prepare such tarballs[1] anyway for kernel.org, it
> > might be worth uploading them to the "Releases" page of git/git.  I
> > imagine there is a programmatic way to do so via GitHub's API, but I
> > don't know offhand. I can look into it if you are interested.
> 
> I already have a script that takes the three tarballs and uploads
> them to two places, so adding GitHub as the third destination should
> be a natural and welcome way to automate it.

I came up with the script below, which you can use like:

  ./script v1.8.2.3 git-1.8.2.3.tar.gz

It expects the tag to already be pushed up to GitHub.  I'll leave
sticking it on the "todo" branch and integrating it into RelUpload to
you. This can also be used to backfill the old releases (though I looked
on k.org and it seems to have only partial coverage).

It sets the "prerelease" flag for -rc releases, but I did not otherwise
fill in any fields, including the summary and description. GitHub seems
to display reasonably if they are not set.

-- >8 --
#!/bin/sh
#
# usage: $0 <tag> <tarball>

repo=git/git

# replace this with however you store your oauth token
# if you don't have one, make one here:
# https://github.com/settings/tokens/new
token() {
  pass -n github.web.oauth
}

post() {
  curl -H "Authorization: token $(token)" "$@"
}

# usage: create <tag-name>
create() {
  case "$1" in
  *-rc*)
    prerelease=true
    ;;
  *)
    prerelease=false
    ;;
  esac

  post -d '
  {
    "tag_name": "'"$1"'",
    "prerelease": '"$prerelease"'
  }' "https://api.github.com/repos/$repo/releases"
}

# use: upload <release-id> <filename>
upload() {
  url="https://uploads.github.com/repos/$repo/releases/$1/assets" &&
  url="$url?name=$(basename $2)" &&
  post -H "Content-Type: $(file -b --mime-type "$2")" \
       --data-binary "@$2" \
       "$url"
}

# This is a hack. If you don't mind a dependency on
# perl's JSON (or another parser), we can do a lot better.
extract_id() {
  perl -lne '/"id":\s*(\d+)/ or next; print $1; exit 0'
}

create "$1" >release.json &&
id=$(extract_id <release.json) &&
upload "$id" "$2" >/dev/null &&
rm -f release.json
