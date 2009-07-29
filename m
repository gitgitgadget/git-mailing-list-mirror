From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: Adding files to a git-archive when it is generated, and whats
	the best way to find out what branch a commit is on?
Date: Wed, 29 Jul 2009 11:12:02 -0500
Message-ID: <20090729161202.GA2443@unpythonic.net>
References: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:12:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWBlJ-0002OX-Q5
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 18:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbZG2QMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 12:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755183AbZG2QMH
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 12:12:07 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:51207 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755071AbZG2QMG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 12:12:06 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 7B53E114916; Wed, 29 Jul 2009 11:12:02 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124364>

When I wanted to add extra files to a tar produced by git-archive, I
used python's tarfile module.  This assumes the tar will fit comfortably
in memory.  The specifics probably don't apply in your case, but maybe
it will be useful anyhow.

You could also use tar's -r or gnu tar's -A modes to add to the
git-archive tar once it's been created:
    git-archive ... > temp.tar
    tar -rf temp.tar additional-file
(unfortunately, -r and -A don't operate on pipes)

def main(args):
    if len(args) == 1:
        version = args[0]
    elif len(args) > 1:
        raise SystemExit, "Usage: %s [version]" % sys.argv[0]
    else:
        status, gitversion = commands.getstatusoutput("git-describe --tags")
        version = highest_version()
        if status != 0 or version != gitversion:
            raise SystemExit, """\
Highest version %r doesn't match description %r.
Specify version number explicitly if this is what you want""" % (
                    version, gitversion)

    version = version.lstrip("v")

    DIRNAME = "%(p)s-%(v)s" % {'p': PACKAGE_NAME, 'v': version}
    TARNAME = DIRNAME + '.tar.gz'

    verstream = StringIO.StringIO("%s\n" % version)
    verinfo = tarfile.TarInfo(DIRNAME + "/VERSION")
    verinfo.mode = 0660
    verinfo.size = len(verstream.getvalue())
    verinfo.mtime = time.time()

    tardata = os.popen("git-archive --prefix=%(p)s/ v%(v)s"
                            % {'p': DIRNAME, 'v': version}).read()
    tarstream = StringIO.StringIO(tardata)

    tar = tarfile.TarFile(mode="a", fileobj=tarstream)
    tar.addfile(verinfo, verstream)
    tar.close()

    out = gzip.open("../" + TARNAME, "wb")
    out.write(tarstream.getvalue())
    out.close()
