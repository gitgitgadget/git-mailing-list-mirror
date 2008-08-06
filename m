From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Wed, 6 Aug 2008 20:11:25 +0400
Message-ID: <37fcd2780808060911g58fbab9ey6188280c8f318854@mail.gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com>
	 <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness>
	 <200807231852.10206.litvinov2004@gmail.com>
	 <alpine.DEB.1.00.0807231356540.8986@racer>
	 <20080806111545.GD32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Alexander Litvinov" <litvinov2004@gmail.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 06 18:12:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQlcm-0008Fq-Ch
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 18:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181AbYHFQL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 12:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756795AbYHFQL2
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 12:11:28 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:51456 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbYHFQL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 12:11:27 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1792471ywe.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=by00i07edUpaJdMbjYx2nliVhUt7TUmAv2i8ZZW9IJQ=;
        b=QkV/k1aWmCpiMHGFHjwLbK4FI+WTM7JEzyEoFntyYcIH5Uo66D6GgKVPX5EqDrj/Ow
         0HYoxt3mhO57zUbxcu4WJ+VFcD5oDapVOFBzj6QfXiiUc2sRNaT46F+ejTqeA4xoUQGt
         EyW8xFJtJX7qXaOmBKDNqoeo21RtLNvpyI+A4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=brmKuKtIJ8BR1SuGRbgQR3br4ABXtTj2Q6LQ2LhGxp0uwJK3Is2/XX1LvyfWL6hpgF
         UtV6VkGM4ssPNOOWiRYl+zMhpNLvvi8i0FYXzyRMFVdwm5mjekf5BDorv23o42RLGKqS
         gQMhGUOC7htC2sYAaZNm9U+IypvrVmVxKgeik=
Received: by 10.142.230.11 with SMTP id c11mr56253wfh.334.1218039086021;
        Wed, 06 Aug 2008 09:11:26 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Wed, 6 Aug 2008 09:11:25 -0700 (PDT)
In-Reply-To: <20080806111545.GD32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91525>

On Wed, Aug 6, 2008 at 3:15 PM, Petr Baudis <pasky@suse.cz> wrote:
>
>  If not, why do you want to drop git-svn from Windows Git? It seems
> that the CRLF issue has trivial workaround to set autocrlf=false;
> this will make git-svn-tracked repositories useful only on Windows,
> but I'd bet this is fine for large majority of Windows git-svn users?

Actually, it is not so simple. If you have svn properties setup correctly
for your text files (i.e. svn:eol-style=native) than autocrlf=false is
not what you want, because then SVN uses LF as EOL when stores this files.

In many case, just setting svn:eol-style correctly in SVN may solve the
problem.

However, to make git-svn work reliable in present files with different
ending, it should import files from SVN  without applying any filter.
Therefore, the --no-filters option was recently added to git-hash-object.
Adding its use to git-svn should be easy (I have not had time to test it):
===
diff --git a/perl/Git.pm b/perl/Git.pm
index 087d3d0..438b7fd 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -829,7 +829,7 @@ sub _open_hash_and_insert_object_if_needed {

        ($self->{hash_object_pid}, $self->{hash_object_in},
         $self->{hash_object_out}, $self->{hash_object_ctx}) =
-               command_bidi_pipe(qw(hash-object -w --stdin-paths));
+               command_bidi_pipe(qw(hash-object -w --stdin-paths
--no-filters));
 }

 sub _close_hash_and_insert_object {
===

This should solve all problem with git-svn fetch. However, if you want to
respect svn:eol-style and when you commit your changes, that will require
synchronization svn:eol-style with values for crlf in your .gitattributes,
which is a much more ambitious task.

Dmitry
