From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: Question: Is it possible to host a writable git repo over both
 http and ssh?
Date: Thu, 26 Mar 2009 11:46:25 +0200
Message-ID: <49CB4EF1.6050902@dawes.za.net>
References: <49CA6A17.6050903@gmail.com> <49CB0AC1.2070006@gmail.com> <20090326045650.GA13628@coredump.intra.peff.net> <200903260618.33019.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Mike Gaffney <mr.gaffo@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 10:49:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmmCp-0000Gt-M8
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 10:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900AbZCZJqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 05:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755576AbZCZJqi
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 05:46:38 -0400
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:39011 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754617AbZCZJqh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 05:46:37 -0400
Received: from artemis.local (unknown [41.246.37.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 48215119E3E;
	Thu, 26 Mar 2009 02:46:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
In-Reply-To: <200903260618.33019.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114761>

Robin Rosenberg wrote:
> torsdag 26 mars 2009 05:56:51 skrev Jeff King <peff@peff.net>:
>> On Wed, Mar 25, 2009 at 11:55:29PM -0500, Mike Gaffney wrote:
>>
>>> I'm actually trying to take what Sean did with gerrit and extract a
>>> full Java/MinaSSHD based server that doesn't require a real user
>>> account and is configurable by spring. So yes, I'm using JGit on the
>>> server.
>> Ah. In that case, I don't know whether JGit respects all hooks. You
>> should ask Shawn (Shawn, we are talking about a post-update to run
>> update-server-info). :)
> 
> Arguably it should. but it doesn't. Then there is a question as to what
> format those hooks should be. Shell scripts would run into platform
> issues and jgit based stuff should have as little as possible of that, but
> a similar mechanism should exist.
> 
> -- robin
> 

Maybe support executing scripts via Bean Scripting Framework?

That would allow scripts to be written in any of the supported
languages, as long as the appropriate interpreter is present.

e.g. BeanShell, Groovy, Jython, etc

See http://jakarta.apache.org/bsf/

If you define an interface for each hook, the scripts could implement
the interface, and execute that way.

Here is an example, mishmashed from
<http://www.beanshell.org/examples/actionhandler.html> and
<http://jvm-languages.com/wiki/Bean_Scripting_Framework#Interacting_with_Complex_Objects>:

======8x===== Java code =========
public class BSFFileUtils
{
   public Object evalFile (BSFManager manager, File file)
       throws IOException
   {
      String fileName = file.getPath();

      String language = manager.getLangFromFilename(fileName);
      String code = extractFileContents(file);

      return manager.eval(language, fileName, 0, 0, code);
   }

   private String extractFileContents (File file)
      throws IOException
   {
      StringBuffer buf = new StringBuffer();

      BufferedReader r = new BufferedReader(new FileReader(file));
      try {
         int len;
         char[] chars = new char[8192];

         while ((len = r.read(chars, 0, chars.length)) != -1) {
           buf.append(chars, 0, len);
         }

         return buf.toString();
      } finally {
          r.close();
      }
   }
}

public static void main (String[] args)
{
   String directory = args[0];
   File file = new File("actionHandler.bsh");

   BSFManager manager = new BSFManager();

   ActionListener listener = (ActionListener)
BSFFileUtils.evalFile(manager, file);

   JButton button = new JButton("MyButton");
   button.addActionListener(listener);

   JFrame f = new JFrame();
   f.getContentPane().add( button );
   f.show();
}

======8x===== BeanShell code ========= actionHandler.bsh

import java.awt.event.ActionListener;

actionPerformed( e ) {
    print("Button Pressed: " + e);
}

return (ActionListener)this;

======8x==============================

Having said all this, it is probably worth implementing
update-server-info in Java, so as to avoid having to shell out to
perform this action, and keep it all platform-independent.

Rogan
