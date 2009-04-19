From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Add support for writing/appending .gitignore file
Date: Sun, 19 Apr 2009 23:50:55 +0200
Message-ID: <200904192350.56348.robin.rosenberg.lists@dewire.com>
References: <AFFAB806-28F7-4D48-B603-B7B96052B0F3@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Alex Blewitt <alex.blewitt@gmail.com>,
	Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sun Apr 19 23:52:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvewH-0006h3-Uw
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 23:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbZDSVvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2009 17:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbZDSVvE
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 17:51:04 -0400
Received: from mail.dewire.com ([83.140.172.130]:20252 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbZDSVvD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Apr 2009 17:51:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 82492149165B;
	Sun, 19 Apr 2009 23:50:59 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e+-Q8iIaRhh9; Sun, 19 Apr 2009 23:50:59 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id CD46D149165A;
	Sun, 19 Apr 2009 23:50:58 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <AFFAB806-28F7-4D48-B603-B7B96052B0F3@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116913>


=46irst, Ferry Huberts is also working on a solution for ignore See=20
http://thread.gmane.org/gmane.comp.version-control.git/114825 though yo=
u=20
focus on different aspects.

s=F6ndag 19 april 2009 15:09:32 skrev Alex Blewitt <alex.blewitt@gmail.=
com>:
> This is in addition to the other patches mailed earlier and attached =
=20
> with issue 64

This patch is whitespace damaged.  Pasting into gmail won't work. Gmail
has authenticated SMTP on port 25 and 465 (SSL) so git-send-email shoul=
d work that way.

> +	private static final String GITIGNORE_ENCODING =3D "UTF-8";

=46or the time being we use Constants.CHARACTER_ENCODING (which
is UTF-8). There are some problems with that too. We read an
interpret (by guessing) (using RawParseUtils.decode) and write UTF-8 (a=
lways).
This is one of git's weak spots; it doesn't define encoding of stuff. F=
or
JGit we do (it's perfectly valid since it's not defined). Our internal
encoding is UTF-8, with fallbacks for accepting other encodings if
it doesn't look like UTF-8. See RawParseUtils.decode() for details.

You may also want to look at msysgit's list of encoding related bug rep=
orts.

> +	private static final String GITIGNORE =3D ".gitignore";
> +
>   	@SuppressWarnings("restriction")
>   	@Override
>   	public void run(IAction action) {
> -
> +		NullProgressMonitor m =3D new NullProgressMonitor();
I guess this method should execute fairly fast, but in general we shoul=
d run
with a real progress monitor. See an action, like Track (maybe we shoul=
d
rename to TrackAction...).

	getTargetPart().getSite().getWorkbenchWindow().run

>   		IResource[] resources =3D getSelectedResources();
> -		for (IResource resource : resources) {
> -			// NB This does the same thing in DecoratableResourceAdapter, but=
 =20
> neither currently consult .gitignore
> -			if (!Team.isIgnoredHint(resource))
> -			{
> -				// TODO Actually add to .gitignore here

I think this series should be one patch only.

> +		try {
> +			for (IResource resource : resources) {
> +				// TODO This is pretty inefficient; multiple ignores in the same=
 =20
> directory cause multiple writes.
> +				// NB This does the same thing in DecoratableResourceAdapter, bu=
t =20
> neither currently consult .gitignore
> +				if (!Team.isIgnoredHint(resource)) {
> +					IContainer container =3D resource.getParent();
> +					IFile gitignore =3D container.getFile(new Path(GITIGNORE));
> +					String entry =3D "/" + resource.getName() + "\n"; //$NON-NLS-1$=
  //=20
> $NON-NLS-2$
> +					// TODO What is the character set and new-line convention?
> +					if(gitignore.exists()) {
> +						// This is ugly. CVS uses an internal representation of =20
> the .gitignore to re-write/overwrite each time.
> +						ByteArrayOutputStream out =3D new ByteArrayOutputStream(2048);
> +						out.write(entry.getBytes(GITIGNORE_ENCODING)); // TODO Default=
 =20
> encoding?
> +						gitignore.appendContents(new =20
> ByteArrayInputStream(out.toByteArray()),true,true,m);
> +					} else {
> +						ByteArrayInputStream bais =3D new =20
> ByteArrayInputStream( entry.getBytes(GITIGNORE_ENCODING) ); //$NON-=20
> NLS-1$
> +						gitignore.create( bais,true,m);				=09
> +					}
The character encoding issues, I think, should be interpreted such that=
 we rewrite the whole
file in the same encoding, should it actually change.

> +				}
>   			}
> +		} catch (UnsupportedEncodingException e) {
> +			// TODO Auto-generated catch block
> +			e.printStackTrace();
> +		} catch (CoreException e) {
> +			// TODO Auto-generated catch block
> +			e.printStackTrace();
> +		} catch (IOException e) {
> +			// TODO Auto-generated catch block
> +			e.printStackTrace();

Some actual error logging would be nice. Activator.logError for just lo=
gging and MessageDialog.openError
for posting an error message to the user.

>   		}
>   		return;
>   	}

-- robin
