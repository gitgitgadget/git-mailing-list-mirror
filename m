From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/3] using stat() to avoid re-scanning pack dir
Date: Sun, 24 May 2015 04:20:16 -0400
Message-ID: <20150524082016.GA8718@peff.net>
References: <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net>
 <7FAE15F0A93C0144AD8B5FBD584E1C551975ADA4@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8DMqj8sCowZ5f-QZMgrAMFjGOaWfYjZWHxs+jvBsDpp5w@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C551975B851@C111KXTEMBX51.ERF.thomson.com>
 <20150522235116.GA4300@peff.net>
 <CACsJy8BjFM_OecoVU9DV3GmJafatSR2yPt6Xb6dETEpYjc1ODA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: steve.norman@thomsonreuters.com,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 10:20:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwR9A-0008R6-1Y
	for gcvg-git-2@plane.gmane.org; Sun, 24 May 2015 10:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbbEXIUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2015 04:20:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:35327 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750763AbbEXIUS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2015 04:20:18 -0400
Received: (qmail 14210 invoked by uid 102); 24 May 2015 08:20:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 May 2015 03:20:18 -0500
Received: (qmail 31509 invoked by uid 107); 24 May 2015 08:20:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 May 2015 04:20:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 May 2015 04:20:16 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BjFM_OecoVU9DV3GmJafatSR2yPt6Xb6dETEpYjc1ODA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269825>

On Sat, May 23, 2015 at 08:19:03AM +0700, Duy Nguyen wrote:

> On Sat, May 23, 2015 at 6:51 AM, Jeff King <peff@peff.net> wrote:
> > The other problem is that I'm not sure stat data is enough to notice
> > when a directory changes. Certainly the mtime should change, but if you
> > have only one-second resolution on your mtimes, we can be fooled.
> 
> mtime may or may not change. I based my untracked-cache series
> entirely on this directory mtime and did some research about it. For
> UNIXy filesystems on UNIXy OSes, mtime should work as you expect. FAT
> on Windows does not (but FAT on Linux does..). NTFS works fine
> according to some MS document. No idea about CIFS. But people often
> just do open operation of a time and this racy is not an issue. It is
> only an issue on the busy server side, and you can make sure you run
> on the right fs+OS.

Even on Linux+ext4, I think there is some raciness.

For instance, the program at the end of this mail will loop forever,
running "stat" on an open directory fd, then enumerating the entries in
the directory.  If we ever get the same stat data as the last iteration
but different contents, then it complains. If you run it alongside
something simple, like touching 10,000 files in the directory, it fails
pretty quickly.

This is because we have no atomicity guarantees with directories. We can
stat() them, and then while we are reading them, somebody else can be
changing the entries. Whether we see the "before" or "after" state
depends on the timing.

I'm not 100% sure this translates into real-world problems for
packfiles. If you notice that an object is missing and re-scan the pack
directory (stat-ing it during the re-scan), then the change that made
the object go missing must have happened _before_ the stat, and would
presumably be reflected in it (modulo mtime resolution issues). But I
haven't thought that hard about it yet, and I have a nagging feeling
that there will be problem cases.

It might be that you could get an "atomic" read of the directory by
doing a stat before and after and making sure they're the same (and if
not, repeating the readdir() calls). But I think that suffers from the
same mtime-resolution problems.

Linux+ext4 _does_ have nanosecond mtimes, which perhaps is enough to
assume that any change will be reflected.

I dunno. I guess the most interesting test would be something closer to
the real world: one process repeatedly making sure the object pointed to
by "master" exists, and another one constantly rewriting "master" and
then repacking the object.

-- >8 --
#include "cache.h"
#include "string-list.h"

static void get_data(const char *path, struct string_list *entries,
		     struct stat_validity *validity)
{
	DIR *dir = opendir(path);
	struct dirent *de;

	stat_validity_update(validity, dirfd(dir));
	while ((de = readdir(dir)))
		string_list_insert(entries, de->d_name);
	closedir(dir);
}

static int list_eq(const struct string_list *a,
		    const struct string_list *b)
{
	int i;

	if (a->nr != b->nr)
		return 0;
	for (i = 0; i < a->nr; i++)
		if (strcmp(a->items[i].string, b->items[i].string))
			return 0;
	return 1;
}

static void monitor(const char *path)
{
	struct string_list last_entries = STRING_LIST_INIT_DUP;
	struct stat_validity last_validity;

	get_data(path, &last_entries, &last_validity);
	while (1) {
		struct string_list cur_entries = STRING_LIST_INIT_DUP;
		struct stat_validity cur_validity;

		get_data(path, &cur_entries, &cur_validity);
		if (!memcmp(&last_validity, &cur_validity, sizeof(last_validity)) &&
		    !list_eq(&cur_entries, &last_entries))
			die("mismatch");

		string_list_clear(&last_entries, 0);
		memcpy(&last_entries, &cur_entries, sizeof(last_entries));
		stat_validity_clear(&last_validity);
		memcpy(&last_validity, &cur_validity, sizeof(last_validity));
	}
}

int main(int argc, const char **argv)
{
	monitor(*++argv);
	return 0;
}
