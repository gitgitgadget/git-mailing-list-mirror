From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 2/2] Make just opening the generated MSVC solution file not
 modify it
Date: Thu, 24 Sep 2009 16:42:42 +0200
Message-ID: <4ABB8562.60104__48109.4558294446$1253803700$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mstormo@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 16:48:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqpc4-0005TN-Rh
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 16:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbZIXOpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 10:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753906AbZIXOpG
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 10:45:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:43908 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899AbZIXOpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 10:45:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MqpZ9-0004WG-7T
	for git@vger.kernel.org; Thu, 24 Sep 2009 16:45:03 +0200
Received: from 91-64-214-160-dynip.superkabel.de ([91.64.214.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 16:45:03 +0200
Received: from sschuberth by 91-64-214-160-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 16:45:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-64-214-160-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129043>

 From 9a0d743e227872189b17afb0b5c69b15422a0eef Mon Sep 17 00:00:00 2001
From: Sebastian Schuberth <sschuberth@gmail.com>
Date: Thu, 24 Sep 2009 16:26:59 +0200
Subject: [PATCH 2/2] Make just opening the generated MSVC solution file not modify it

The format of the generated MSVC solution file is fixed in a way that just
opening it in Visual Studio and immediately closing it again without performing
any modifications does not trigger a prompt to save the solution file. This
behavior was caused by several minor incompatibilities between the generated
file and what Visual Studio 2008 expected, so Visual Studio transparently fixed
the file format, marking it internally as modified.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
  contrib/buildsystems/Generators/Vcproj.pm |   42 +++++++---------------------
  1 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/contrib/buildsystems/Generators/Vcproj.pm b/contrib/buildsystems/Generators/Vcproj.pm
index 50daa03..d53ff2c 100644
--- a/contrib/buildsystems/Generators/Vcproj.pm
+++ b/contrib/buildsystems/Generators/Vcproj.pm
@@ -571,45 +571,29 @@ sub createGlueProject {
          print F "\"${libname}\", \"${libname}\\${libname}.vcproj\", \"${uuid}\"";
          print F "$SLN_POST";
      }
+    my $uuid_libgit = $build_structure{"LIBS_libgit_GUID"};
+    my $uuid_xdiff_lib = $build_structure{"LIBS_xdiff_lib_GUID"};
      foreach (@apps) {
          my $appname = $_;
          my $uuid = $build_structure{"APPS_${appname}_GUID"};
          print F "$SLN_PRE";
-        print F "\"${appname}\", \"${appname}\\${appname}.vcproj\", \"${uuid}\"";
+        print F "\"${appname}\", \"${appname}\\${appname}.vcproj\", \"${uuid}\"\n";
+        print F "	ProjectSection(ProjectDependencies) = postProject\n";
+        print F "		${uuid_libgit} = ${uuid_libgit}\n";
+        print F "		${uuid_xdiff_lib} = ${uuid_xdiff_lib}\n";
+        print F "	EndProjectSection";
          print F "$SLN_POST";
      }
  
      print F << "EOM";
  Global
-	GlobalSection(SolutionConfiguration) = preSolution
-		ConfigName.0 = Debug|Win32
-		ConfigName.1 = Release|Win32
+	GlobalSection(SolutionConfigurationPlatforms) = preSolution
+		Debug|Win32 = Debug|Win32
+		Release|Win32 = Release|Win32
  	EndGlobalSection
-	GlobalSection(ProjectDependencies) = postSolution
  EOM
-    foreach (@{$build_structure{"APPS"}}) {
-        my $appname = $_;
-        my $appname_clean = $_;
-        $appname_clean =~ s/\//_/g;
-        $appname_clean =~ s/\.exe//;
-
-        my $uuid = $build_structure{"APPS_${appname_clean}_GUID"};
-        my $dep_index = 0;
-        foreach(@{$build_structure{"APPS_${appname}_LIBS"}}) {
-            my $libname = $_;
-            $libname =~ s/\//_/g;
-            $libname =~ s/\.(a|lib)//;
-            my $libuuid = $build_structure{"LIBS_${libname}_GUID"};
-            if (defined $libuuid) {
-                print F "\t\t${uuid}.${dep_index} = ${libuuid}\n";
-                $dep_index += 1;
-            }
-        }
-    }
-
      print F << "EOM";
-	EndGlobalSection
-	GlobalSection(ProjectConfiguration) = postSolution
+	GlobalSection(ProjectConfigurationPlatforms) = postSolution
  EOM
      foreach (@libs) {
          my $libname = $_;
@@ -630,10 +614,6 @@ EOM
  
      print F << "EOM";
  	EndGlobalSection
-	GlobalSection(ExtensibilityGlobals) = postSolution
-	EndGlobalSection
-	GlobalSection(ExtensibilityAddIns) = postSolution
-	EndGlobalSection
  EndGlobal
  EOM
      close F;
-- 
1.6.4.msysgit.0
